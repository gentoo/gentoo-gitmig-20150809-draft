# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.23.ebuild,v 1.14 2004/07/15 03:13:24 agriffis Exp $

DESCRIPTION="GNU lexical analyser generator"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://lex.sourceforge.net/"

SLOT="0"
LICENSE="FLEX"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="build nls static"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"


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
