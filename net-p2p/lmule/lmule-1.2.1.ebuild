# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lmule/lmule-1.2.1.ebuild,v 1.1 2003/06/08 15:47:15 malverian Exp $

DESCRIPTION="GPL eDonkey clone that doesn't suck"
HOMEPAGE="http://lmule.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86"

DEPEND=">=x11-libs/wxGTK-2.4
	>=sys-libs/zlib-1.1.4"

S=${WORKDIR}/${P}

src_compile () {
	econf || die
	emake || die
}

src_install () {
	einstall || die
}
