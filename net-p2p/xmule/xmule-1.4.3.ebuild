# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/xmule/xmule-1.4.3.ebuild,v 1.3 2003/08/19 23:11:19 scandium Exp $

DESCRIPTION="wxWindows based client for the eDonkey/eMule/lMule network"
HOMEPAGE="http://www.xmule.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86"

DEPEND=">=x11-libs/wxGTK-2.4
	>=sys-libs/zlib-1.1.4"

S=${WORKDIR}/${P}

src_compile () {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install () {
	einstall || die
}

pkg_postinst() {
        echo
        einfo "This version of xmule has a security hole related to"
        einfo "the function OP_SERVERMESSAGE"
        einfo "Use it at your own risk !"
        echo
}

