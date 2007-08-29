# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2570/rt2570-1.1.0_beta2.ebuild,v 1.3 2007/08/29 19:00:26 genstef Exp $

inherit eutils linux-mod

MY_P="${P/_beta/-b}"
DESCRIPTION="Driver for the RaLink RT2570 USB wireless chipset"
HOMEPAGE="http://rt2x00.serialmonkey.com"
SRC_URI="http://rt2x00.serialmonkey.com/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="net-wireless/wireless-tools"

S=${WORKDIR}/${MY_P}
MODULE_NAMES="rt2570(net:${S}/Module)"
CONFIG_CHECK="WIRELESS_EXT BROKEN_ON_SMP"
BROKEN_ON_SMP_ERROR="SMP Processors and Kernels are currently not supported"

pkg_setup() {
	linux-mod_pkg_setup
	if use_m
	then BUILD_PARAMS="-C ${KV_DIR} M=${S}/Module"
		 BUILD_TARGETS="modules"
	else die "please use a kernel >=2.6.6"
	fi
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	dodoc Module/TESTING Module/iwpriv_usage.txt THANKS FAQ CHANGELOG
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "to set up the card you can use:"
	elog "- iwconfig from wireless-tools"
	elog "- iwpriv, like described in \"/usr/share/doc/${PF}/iwpriv_usage.txt.gz"\"
}
