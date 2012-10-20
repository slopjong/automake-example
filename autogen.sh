#!/bin/bash

function _autoreconf {
	autoreconf --verbose --force --install
}

if [ $# -gt 0 ] ; then
	case "$1" in
		clean)
			[[ -f Makefile ]] && make distclean
			autogenerated="aclocal.m4 autom4te.* config.* configure depcomp install-sh Makefile.in missing compile stamp* *.scan *.log"
			for file in $autogenerated
			do
				[[ -f $file ]] && rm $file
				[[ -d $file ]] && rm -rf $file
			done
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
