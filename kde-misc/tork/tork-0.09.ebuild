# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.09.ebuild,v 1.1 2006/10/19 01:15:51 flameeyes Exp $

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
	${DEPEND}"

need-kde 3.5

PATCHES="${FILESDIR}/${P}-gcc41.patch"

src_compile() {
	local myconf="--with-external-geoip"
	kde_src_compile
}

src_install() {
	kde_src_install
	rm -rf "${D}/usr/share/applnk"
}
