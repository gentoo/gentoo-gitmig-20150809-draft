# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.23.ebuild,v 1.3 2007/12/15 14:37:09 cla Exp $

inherit kde multilib

DESCRIPTION="A Tor controller for the KDE desktop"
HOMEPAGE="http://tork.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/openssl
	>=dev-libs/geoip-1.4.0
	|| ( kde-base/kdebase kde-base/libkonq )"

RDEPEND="${DEPEND}
	>=net-misc/tor-0.1.2.14
	>=net-proxy/privoxy-3.0.3-r5
	>=net-proxy/tsocks-1.8_beta5-r2"

need-kde 3.5

PATCHES="${FILESDIR}/${PN}-0.20-ext_tsocks.patch"

src_compile() {
	# Fix desktop file
	sed -i -e "s:^\(Categories=.*\):\1;:" "${S}/src/tork.desktop"

	local myconf="--with-external-geoip --with-conf=/etc/socks/tsocks.conf"
	kde_src_compile
}

pkg_postinst() {
	if ! built_with_use --missing false net-proxy/tsocks tordns; then
		ewarn "WARNING: you have net-proxy/tsocks installed without"
		ewarn "the patch to avoid DNS leaking while using Tor."
		ewarn "For better privacy, please emerge again net-proxy/tsocks"
		ewarn "with the USE flag 'tordns' enabled."
	fi
}
