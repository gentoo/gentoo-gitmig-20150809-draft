# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r4.ebuild,v 1.2 2001/10/18 20:58:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/ncurses/${P}.tar.gz ftp://dickey.his.com/ncurses/5.2/patch-5.2-20010512.sh ftp://dickey.his.com/ncurses/5.2/${P}-20010618.patch.gz ftp://dickey.his.com/ncurses/5.2/${P}-20010616.patch.gz ftp://dickey.his.com/ncurses/5.2/${P}-20010609.patch.gz ftp://dickey.his.com/ncurses/5.2/${P}-20010603.patch.gz ftp://dickey.his.com/ncurses/5.2/${P}-20010602.patch.gz ftp://dickey.his.com/ncurses/5.2/${P}-20010526.patch.gz ftp://dickey.his.com/ncurses/5.2/${P}-20010519.patch.gz"

HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
DEPEND="virtual/glibc"
src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	sh ${DISTDIR}/patch-5.2-20010512.sh
	local x
	for x in 0519 0526 0602 0603 0609 0616 0618
	do
		gzip -dc ${DISTDIR}/${P}-2001${x}.patch.gz | patch -p1 || die
	done
}

src_compile() {
	if [ -z "$DEBUG" ]
	then
	myconf="${myconf} --without-debug"
	fi
	rm -rf test
	./configure --prefix=/usr --libdir=/lib --mandir=/usr/share/man --enable-symlinks --enable-termcap --with-shared --with-rcs-ids --host=${CHOST}  ${myconf} || die
	echo "all:" > test/Makefile
	# Parallel make fails sometimes so I removed MAKEOPTS
	make || die
}

src_install() {
	dodir /usr/lib
	echo "install:" >> test/Makefile
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

	cd ${S}

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



