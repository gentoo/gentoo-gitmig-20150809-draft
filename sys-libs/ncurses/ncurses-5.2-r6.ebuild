# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.2-r6.ebuild,v 1.1 2002/09/03 21:11:29 azarah Exp $

inherit flag-o-matic

filter-flags "-fno-exceptions"

S=${WORKDIR}/${P}
DESCRIPTION="Linux console display libarary"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"

KEYWORDS="x86 sparc sparc64"
LICENSE="MIT"
SLOT="5"

DEPEND="virtual/glibc"


src_unpack() {
	unpack ${A}

	cd ${S}
	# Do not compile tests
	rm -rf test/*
	echo "all:" > test/Makefile.in
	echo "install:" >> test/Makefile.in
}

src_compile() {

	[ -z "${DEBUG}" ] && myconf="${myconf} --without-debug"
	
	econf --libdir=/lib \
		--enable-symlinks \
		--disable-termcap \
		--with-shared \
		--with-rcs-ids \
		${myconf} || die
	
	#emake still doesn't work circa 25 Mar 2002
	make || die
}

src_install() {

	dodir /usr/lib
	make DESTDIR=${D} install || die

	cd ${D}/lib
	dosym libncurses.a /lib/libcurses.a
	chmod 755 ${D}/lib/*.${PV}
	mv libform* libmenu* libpanel* ../usr/lib
	mv *.a ../usr/lib

	#with this fix, the default xterm has color as it should
	cd ${D}/usr/share/terminfo/x
	mv xterm xterm.orig
	dosym xterm-color /usr/share/terminfo/x/xterm

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

