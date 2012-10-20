#!/bin/bash

function _autoreconf {
	autoreconf --verbose --force --install
}

if [ $# -gt 0 ] ; then
	case "$1" in
		clean)
			[[ -f Makefile ]] && make distclean
			rm -rf aclocal.m4 autom4te.cache config.h* configure depcomp install-sh Makefile.in missing compile
			;;
			
		conf)
			_autoreconf
			shift 1
			exec ./configure "$@"
			;;
			
		*)
			echo $"Usage: $0 [clean|conf]"
			exit 1
			;;
		
	esac
else
	_autoreconf
fi
