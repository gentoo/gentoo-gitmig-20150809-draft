# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r5.ebuild,v 1.5 2002/08/04 16:25:48 spider Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
DEPEND="virtual/glibc"
KEYWORDS="x86"
LICENSE="MIT"
SLOT="5"

filter-flags -fno-exceptions

src_compile() {
	if [ -z "$DEBUG" ]
	then
		myconf="${myconf} --without-debug"
	fi
	rm -rf test
	./configure --prefix=/usr --libdir=/lib --mandir=/usr/share/man --enable-symlinks --enable-termcap --with-shared --with-rcs-ids --host=${CHOST}  ${myconf} || die
	echo "all:" > test/Makefile
	#emake still doesn't work circa 25 Mar 2002
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



