# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mktorrent/mktorrent-0.4.ebuild,v 1.3 2008/01/29 12:24:25 drac Exp $

inherit toolchain-funcs

DESCRIPTION="Simple command line utility to create BitTorrent metainfo files"
HOMEPAGE="http://mktorrent.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-libs/openssl"

src_unpack() {
	unpack ${A}
	sed -i -e 's:-lssl:-lcrypto:' "${S}"/Makefile
}

src_compile() {
	tc-export CC
	emake DONT_STRIP=1 || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc README
}
