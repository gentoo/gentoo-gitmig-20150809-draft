# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.7.1.ebuild,v 1.4 2008/06/29 14:04:11 nixnut Exp $

inherit eutils autotools

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
HOMEPAGE="http://www.roland-riegel.de/nload/index.html"
SRC_URI="mirror://sourceforge/nload/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.6.0-prevent-stripping.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
