# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xchm/xchm-0.7.1.ebuild,v 1.2 2003/09/09 19:21:43 mholzer Exp $

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://xchm.sf.net"
SRC_URI="mirror://sourceforge/xchm/${P}.tar.gz
	doc? ( mirror://sourceforge/xchm/${P}-doc.tar.gz ) "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"
DEPEND=">=dev-libs/chmlib-0.31
	>=x11-libs/wxGTK-2.4.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc COPYING AUTHORS README NEWS

	if [ "`use doc`" ]; then
	cd ${S}"-doc"
	dohtml html/*
	fi
}
