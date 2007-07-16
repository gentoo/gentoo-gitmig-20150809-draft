# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2500/rt2500-1.1.0_pre2007071515.ebuild,v 1.2 2007/07/16 11:23:54 uberlord Exp $

inherit eutils linux-mod

MY_P="${P/_beta/-b}"
DESCRIPTION="Driver for the RaLink RT2500 wireless chipset"
HOMEPAGE="http://rt2x00.serialmonkey.com"
#SRC_URI="mirror://sourceforge/rt2400/${MY_P}.tar.gz"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="amd64 hppa ppc x86"
IUSE=""
DEPEND="net-wireless/wireless-tools"

MY_PRE_VERSION=${PV/1.1.0_pre}
S="${WORKDIR}/${PN}-cvs-${MY_PRE_VERSION}"

MODULE_NAMES="rt2500(net:${S}/Module)"
MODULESD_RT2500_ALIASES=('ra? rt2500')

pkg_setup() {
	if kernel_is ge 2 6 22; then
		CONFIG_CHECK="WIRELESS_EXT ${CONFIG_CHECK}"
	else
		CONFIG_CHECK="NET_RADIO ${CONFIG_CHECK}"
	fi

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
