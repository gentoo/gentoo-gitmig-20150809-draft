# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mktorrent/mktorrent-0.2.ebuild,v 1.1 2007/10/16 16:29:58 armin76 Exp $

DESCRIPTION="Simple command line utility to create BitTorrent metainfo files"
HOMEPAGE="http://mktorrent.sourceforge.net/"
SRC_URI="mirror://sourceforge/mktorrent/mktorrent-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/openssl"

src_unpack() {
	unpack ${A}
	sed -i 's/^#DONT_STRIP/DONT_STRIP/' "${S}"/Makefile
}

src_install() {
	dobin mktorrent || die "dobin failed"
	dodoc README
}
