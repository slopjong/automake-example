AC_PREREQ([2.65])
AC_INIT([My hello world example], [0.1])
AM_INIT_AUTOMAKE([1.11 no-define foreign subdir-objects])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AM_PROG_CC_C_O

# Checks for header files.
AC_PATH_X
AC_CHECK_HEADERS([stdlib.h unistd.h])

# Checks for library functions.
AC_CHECK_LIB([X11], [XOpenDisplay], [],[
         echo "X11 library is required for this program"
         exit -1])
	 
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
