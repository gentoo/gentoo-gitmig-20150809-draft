# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.2a-r1.ebuild,v 1.9 2003/06/22 05:10:31 seemant Exp $

inherit eutils gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="Another cute console display library"
SRC_URI="ftp://ftp.gnu.org/gnu/readline/${P}.tar.gz
	 ftp://gatekeeper.dec.com/pub/GNU/readline/${P}.tar.gz"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"

KEYWORDS="x86 ppc sparc alpha mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.2-r2
	>=app-shells/bash-2.05a-r3"

src_unpack() {
	unpack ${A}
	
	# config.sub doesn't recognize alphaev67+, update it
	use alpha && gnuconfig_update
}

src_compile() {

	econf --with-curses || die
	
	emake || die
	cd shlib
	emake || die
}


src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die
	cd shlib
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die

	cd ..

	sed -i "s/#  include <config.h>//" tilde.h
	insinto /usr/include/readline
	doins tilde.h

	dodir /lib
	mv ${D}/usr/lib/*.so* ${D}/lib
	# bug #4411
	gen_usr_ldscript libreadline.so
	gen_usr_ldscript libhistory.so
	# end bug #4411
	dosym libhistory.so.${PV/a/} /lib/libhistory.so
	dosym libreadline.so.${PV/a/} /lib/libreadline.so
	# Needed because make install uses ${D} for the link
	dosym libhistory.so.${PV/a/} /lib/libhistory.so.4
	dosym libreadline.so.${PV/a/} /lib/libreadline.so.4
	chmod 755 ${D}/lib/*.${PV/a/}

	dodoc CHANGELOG CHANGES COPYING MANIFEST README USAGE
	docinto ps
	dodoc doc/*.ps
	docinto html
	dodoc doc/*.html
}

