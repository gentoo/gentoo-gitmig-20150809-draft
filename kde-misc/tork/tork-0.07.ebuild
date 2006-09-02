# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.07.ebuild,v 1.1 2006/09/02 18:41:49 flameeyes Exp $

inherit kde

DESCRIPTION="A Tor controller for the KDE desktop"
HOMEPAGE="http://tork.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="net-misc/tor
	dev-libs/openssl
	>=dev-libs/geoip-1.4.0
	>=net-proxy/privoxy-3.0.3-r5"

need-kde 3.5

PATCHES="${FILESDIR}/${P}-geoip.patch
	${FILESDIR}/${P}-qt335.patch"

src_unpack() {
	kde_src_unpack
	rm -rf "${S}/src/GeoIP-1.4.0" "${S}/configure"
}

src_install() {
	kde_src_install
	rm -rf "${D}/usr/share/applnk"
}
