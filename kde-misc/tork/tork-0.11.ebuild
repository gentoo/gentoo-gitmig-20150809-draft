# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.11.ebuild,v 1.1 2006/11/14 12:27:10 flameeyes Exp $

inherit kde

DESCRIPTION="A Tor controller for the KDE desktop"
HOMEPAGE="http://tork.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/openssl
	>=dev-libs/geoip-1.4.0"

RDEPEND="net-misc/tor
	>=net-proxy/privoxy-3.0.3-r5
	net-proxy/tsocks
	${DEPEND}"

need-kde 3.5

PATCHES="${FILESDIR}/${P}-external-tsocks.patch"

src_compile() {
	rm -f "${S}/configure"

	local myconf="--with-external-geoip --with-external-tsocks"
	kde_src_compile
}

src_install() {
	kde_src_install
	rm -rf "${D}/usr/share/applnk"
}
