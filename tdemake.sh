#!/bin/bash
. $(dirname $0)/environ.sh path pkgconfig ldpath || {
	echo "Could not source environ.sh"
	exit 66
}

CMAKE=0
AUTOCONF=0

CFLAGS="-I$TQTDIR/include/tqt $CFLAGS"
CXXFLAGS="-I$TQTDIR/include/tqt $CXXFLAGS"
LDFLAGS="-L$TQTDIR/lib"

test -z "$1" -o "$1" == "-h" -o "$1" == "--help" && {
	echo "$0 [--help|-h] | [--cmake|-c] [--autoconf|-a]"
	echo
	echo "You have a choice of building either with"
	echo "CMake (recommended) or Autotools."
	echo
	echo "Not all packages can be built with one or another."
	echo
	echo "(This script was modified to suit the needs of"
	echo "trinity-ubs)."
	exit 0
}

for arg in $*
do
	test "$arg" == "-c" -o "$arg" == "--cmake" && {
		CMAKE=1
	}

	test "$arg" == "-a" -o "$arg" == "--autoconf" && {
		AUTOCONF=1
	}
done

test "$CMAKE" -eq 1 -a "$AUTOCONF" -eq 1 && {
	echo "Choose either CMake or Autotools (not both!)"
	exit 2
}

function build_cmake {

	test -d build && rm -r build
	mkdir build
	cd build

	cmake .. \
		-DCMAKE_C_FLAGS:STRING="$CPUOPTIONS" \
		-DCMAKE_CXX_FLAGS:STRING="$CPUOPTIONS" \
		-DCMAKE_INSTALL_PREFIX=$TDEPREFIX \
		-DSYSCONF_INSTALL_DIR=$TDESYSCONFDIR \
		-DBUILD_ALL=ON || exit $?
 	make || exit $?
	sudo make install || exit $?
}

function build_autoconf {
	cp -Rp /usr/share/aclocal/libtool.m4 admin/libtool.m4.in
	cp -Rp /usr/share/libtool/build-aux/ltmain.sh admin/ltmain.sh
	make -f admin/Makefile.common

	CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGSS" LDFLAGS="$LDFLAGS" \
	 ./configure \
		--prefix=$TDEPREFIX \
		--sysconfdir=$TDESYSCONFDIR \
		--libdir=$TDEPREFIX/lib \
		--with-tqt-dir=$TQTDIR || exit $?

	make || exit $?
	make install || exit $?
}

test $CMAKE -eq 1 && {
    build_cmake
    exit $?
}
test $AUTOCONF -eq 1 && {
    build_autoconf
    exit $?
}
