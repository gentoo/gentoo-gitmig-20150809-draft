# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2.20020112a-r1.ebuild,v 1.4 2002/08/14 04:08:01 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Linux console display library"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/n/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
DEPEND="virtual/glibc"
KEYWORDS="x86 sparc sparc64"
LICENSE="MIT"
SLOT="5"

src_compile() {
	if [ -z "$DEBUG" ]
	then
		myconf="${myconf} --without-debug"
	fi
	rm -rf test
	./configure --prefix=/usr --libdir=/lib --mandir=/usr/share/man --enable-symlinks --enable-termcap --with-shared --with-rcs-ids --host=${CHOST}  ${myconf} || die
	echo "all:" > test/Makefile
	# fix to make apps using ncurses compile correctly with gcc3
	mv include/unctrl.h include/unctrl.h_orig
	sed -e "s:#include <curses.h>:#include <curses.h>\n#include <ncurses_dll.h>:" \
		include/unctrl.h_orig > include/unctrl.h
	# Parallel make fails sometimes so I removed MAKEOPTS
	make || die
}

src_install() {
	dodir /usr/lib
	echo "install:" >> ${S}/test/Makefile
	make DESTDIR=${D} install || die

	cd ${D}/lib
	ln -s libncurses.a libcurses.a
	chmod 755 ${D}/lib/*.${PV}
	dodir /usr/lib
	mv libform* libmenu* libpanel* ../usr/lib
	mv *.a ../usr/lib

	#with this fix, the default xterm has color as it should
	cd ${D}/usr/share/terminfo/x
	mv xterm xterm.orig
	ln -s xterm-color xterm

	if [ "`use build`" ]
	then
		cd ${D}
		rm -rf usr/share/man
		cd usr/share/terminfo
		cp -a l/linux n/nxterm v/vt100 ${T}
		rm -rf *
		mkdir l x v
		cp -a ${T}/linux l
		cp -a ${T}/nxterm x/xterm
		cp -a ${T}/vt100 v
		cd ${D}/usr/lib
		#bash compilation requires static libncurses libraries, so
		#this breaks the "build a new build image" system.  We now
		#need to remove libncurses.a from the build image manually.	
		#rm *.a
	else
		cd ${S}
		dodoc ANNOUNCE MANIFEST NEWS README* TO-DO
		dodoc doc/*.doc
		dohtml -r doc/html/
#		docinto html/ada
#		dodoc doc/html/ada/*.htm
#		docinto html/ada/files
#		dodoc doc/html/ada/files/*.htm
#		docinto html/ada/funcs
#		dodoc doc/html/ada/funcs/*.htm
#		docinto html/man
#		dodoc doc/html/man/*.html
	fi
}



