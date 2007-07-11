# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwlwifi/iwlwifi-0.0.36.ebuild,v 1.1 2007/07/11 03:26:05 compnerd Exp $

inherit linux-mod

DESCRIPTION="Intel (R) PRO/Wireless 3945ABG Network Drivers"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/${PN}/downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( net-wireless/iwl3945-ucode net-wireless/iwl4965-ucode )"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="all"
	MODULE_NAMES="iwl3945(net/wireless:${S}/compatible) iwl4965(net/wireless:${S}/compatible)"
	BUILD_PARAMS="KSRC=${KV_DIR} M=${S}"
}
