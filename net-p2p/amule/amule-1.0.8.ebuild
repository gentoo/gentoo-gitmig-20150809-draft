# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-1.0.8.ebuild,v 1.2 2003/10/18 17:17:26 scandium Exp $

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aNOTHER wxWindows based eMule P2P Client"
HOMEPAGE="http://sourceforge.net/projects/amule"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4.1
	>=sys-libs/zlib-1.1.4"

src_compile () {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install () {
	einstall || die
}
