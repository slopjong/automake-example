#include <X11/X.h>
#include <X11/Xlib.h>

int
main(int argc, char * argv [])
{
  Display * disp;
  Window win;
  int scr;
  XSetWindowAttributes attr;
  XEvent ev;
  GC gc;
  XGCValues gc_attr;

  int h, w;
  int done = 0;

  int line_skip = 50;

  disp = XOpenDisplay(NULL);
  scr = DefaultScreen(disp);

  h = w = 200;

  bzero(&attr, sizeof(attr));
  attr.background_pixel = BlackPixel(disp, scr);
  attr.event_mask = (KeyPressMask | ExposureMask | StructureNotifyMask);
  win = XCreateWindow(disp, RootWindow(disp, scr),
		      10, 10, h, w,
		      0, DefaultDepth(disp, scr),
		      InputOutput, DefaultVisual(disp, scr),
		      CWBackPixel | CWEventMask,
		      &attr);

  XMapWindow(disp, win);

  bzero(&gc_attr, sizeof(gc_attr));
  gc_attr.function = GXcopy;
  gc_attr.foreground = WhitePixel(disp, scr);
  gc_attr.background = BlackPixel(disp, scr);
  gc_attr.line_width = 1;

  gc = XCreateGC(disp, win,
		 GCFunction | GCForeground | GCBackground | GCLineWidth,
		 &gc_attr);

  while (!done) {
    XNextEvent(disp, &ev);
    switch (ev.type) {
    case KeyPress:
      {
	XKeyEvent * ke = (XKeyEvent *) &ev;
	KeySym ks;
	char * s;

	ks = XKeycodeToKeysym(disp, ke->keycode, 0);
	s = XKeysymToString(ks);

	if (s[0] == 'q') {
	  done = 1;
	}
      }
      break;
    case Expose:
      {
	int i;
	XExposeEvent * e = (XExposeEvent *) &ev;

	XClearArea(disp, win, e->x, e->y, e->width, e->height, 0);

	for (i = line_skip; i < h; i += line_skip) {
	  XDrawLine(disp, win, gc, 0, i, w-1, i);
	}
	for (i = line_skip; i < w; i += line_skip) {
	  XDrawLine(disp, win, gc, i, 0, i, h-1);
	}
      }
      break;
    case ConfigureNotify:
      {
	XConfigureEvent * ce = (XConfigureEvent *) & ev;

	h = ce->height;
	w = ce->width;
      }
      break;
    }
  }

  XCloseDisplay(disp);
}
