# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r4.ebuild,v 1.7 2002/07/11 06:30:56 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz http://www.ibiblio.org/gentoo/distfiles/ncurses-5.2-20010908.patch.gz"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html http://dickey.his.com"
DEPEND="virtual/glibc"
KEYWORDS="x86"
LICENSE="MIT"
SLOT="5"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	cat ${DISTDIR}/ncurses-5.2-20010908.patch.gz | gzip -d | patch -p1 || die
}

src_compile() {
	if [ -z "$DEBUG" ]
	then
		myconf="${myconf} --without-debug"
	fi
	rm -rf test
	./configure --prefix=/usr --libdir=/lib --mandir=/usr/share/man --enable-symlinks --enable-termcap --with-shared --with-rcs-ids --host=${CHOST}  ${myconf} || die
	echo "all:" > test/Makefile
	echo "install:" >> test/Makefile
	# Parallel make fails sometimes so I removed MAKEOPTS
	make || die
}

src_install() {
	dodir /usr/lib
	make DESTDIR=${D} install || die

	cd ${D}/lib
	ln -s libncurses.a libcurses.a
	chmod 755 ${D}/lib/*.${PV}
	dodir /usr/lib
	mv libform* libmenu* libpanel* ../usr/lib
	mv *.a ../usr/lib
	dosym /lib/libncurses.so /usr/lib/libncurses.so.5.2

	#with this fix, the default xterm has color as it should
	cd ${D}/usr/share/terminfo/x
	mv xterm xterm.orig
	ln -s xterm-color xterm

	if [ "`use build`" ]
	then
		cd ${D}
		rm -rf usr/share/man
		cd usr/share/terminfo
		cp -a l/linux x/xterm v/vt100 ${T}
		rm -rf *
		mkdir l x v
		cp -a ${T}/linux l
		cp -a ${T}/xterm x
		cp -a ${T}/vt100 v
		cd ${D}/usr/lib
		rm *.a
	else
		cd ${S}
		dodoc ANNOUNCE MANIFEST NEWS README* TO-DO
		dodoc doc/*.doc
		docinto html
		dodoc doc/html/*.html
		docinto html/ada
		dodoc doc/html/ada/*.htm
		docinto html/ada/files
		dodoc doc/html/ada/files/*.htm
		docinto html/ada/funcs
		dodoc doc/html/ada/funcs/*.htm
		docinto html/man
		dodoc doc/html/man/*.html
	fi
}



