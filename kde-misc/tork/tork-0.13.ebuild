# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.13.ebuild,v 1.2 2007/01/28 17:39:08 flameeyes Exp $

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

RDEPEND=">=net-misc/tor-0.1.2.3
	>=net-proxy/privoxy-3.0.3-r5
	net-proxy/tsocks
	${DEPEND}"

need-kde 3.5

src_compile() {
	local myconf="--with-external-geoip --with-external-tsocks"
	kde_src_compile
}

src_install() {
	kde_src_install
	rm -rf "${D}/usr/share/applnk"
}

pkg_postinst() {
	if ! built_with_use --missing false net-proxy/tsocks tordns; then
		ewarn "WARNING: you have net-proxy/tsocks installed without"
		ewarn "the patch to avoid DNS leaking while using Tor."
		ewarn "For better privacy, please emerge again net-proxy/tsocks"
		ewarn "with the USE flag 'tordns' enabled."
	fi
}
