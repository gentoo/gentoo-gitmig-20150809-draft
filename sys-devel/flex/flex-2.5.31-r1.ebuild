# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.31-r1.ebuild,v 1.7 2004/07/15 03:13:24 agriffis Exp $

inherit eutils

DESCRIPTION="GNU lexical analyser generator"
SRC_URI="mirror://sourceforge/lex/${P}.tar.bz2"
HOMEPAGE="http://lex.sourceforge.net/"

SLOT="0"
LICENSE="FLEX"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ppc64"
IUSE="build nls static"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-yytext_ptr.patch
}

src_compile() {
	myconf=""

	use nls || myconf="--disable-nls"

	econf ${myconf} || die

	if ! use static
	then
		emake || make || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	einstall || die

	if ! use build
	then
		dodoc AUTHORS COPYING ChangeLog NEWS ONEWS README* RoadMap THANKS TODO
	else
		rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib
	fi

	dosym flex /usr/bin/lex
}
