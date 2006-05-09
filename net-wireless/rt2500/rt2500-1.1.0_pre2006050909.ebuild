# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2500/rt2500-1.1.0_pre2006050909.ebuild,v 1.1 2006/05/09 18:22:24 uberlord Exp $

inherit eutils linux-mod

DESCRIPTION="Driver for the RaLink RT2500 wireless chipset"
HOMEPAGE="http://rt2x00.serialmonkey.com"
SRC_URI="mirror://gentoo//${PF}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="net-wireless/wireless-tools"

S="${WORKDIR}/${PN}-cvs-${PV##*_pre}"

MODULE_NAMES="rt2500(net:${S}/Module)"
CONFIG_CHECK="NET_RADIO"
MODULESD_RT2500_ALIASES=('ra? rt2500')

pkg_setup() {
	linux-mod_pkg_setup
	if use_m ; then
		BUILD_PARAMS="-C ${KV_DIR} M=${S}/Module"
		BUILD_TARGETS="modules"
	else
		die "please use a kernel >=2.6.6"
	fi
}

src_install() {
	linux-mod_src_install

	dodoc Module/README Module/TESTING Module/iwpriv_usage.txt \
		THANKS FAQ CHANGELOG
}
