# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rfswitch/rfswitch-0.1-r1.ebuild,v 1.1 2005/04/28 12:39:55 brix Exp $

inherit linux-mod

DESCRIPTION="Drivers for software based wireless radio switches"
HOMEPAGE="http://rfswitch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
RDEPEND="!<=net-wireless/ipw2100-0.48"

BUILD_TARGETS="modules"

MODULE_NAMES="av5100(net/wireless:)
			  pbe5(net/wireless:)"
MODULESD_AV5100_DOCS="README"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KSRC=${KV_DIR}"
}

src_unpack() {
	unpack ${A}

	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	dodoc ISSUES
}
