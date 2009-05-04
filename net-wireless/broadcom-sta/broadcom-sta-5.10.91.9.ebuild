# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/broadcom-sta/broadcom-sta-5.10.91.9.ebuild,v 1.2 2009/05/04 23:57:49 matsuu Exp $

inherit eutils linux-mod versionator

MY_PV="$(replace_all_version_separators _)"
DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver."
HOMEPAGE="http://www.broadcom.com/support/802.11/linux_sta.php"
SRC_BASE="http://www.broadcom.com/docs/linux_sta/hybrid-portsrc-x86_"
SRC_URI="x86? ( ${SRC_BASE}32-v${MY_PV}.tar.gz )
	amd64? ( ${SRC_BASE}64-v${MY_PV}.tar.gz )"

LICENSE="Broadcom"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/linux-sources-2.6.22"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

MODULE_NAMES="wl(net/wireless)"
MODULESD_WL_ALIASES=("wlan0 wl")

pkg_setup() {
	check_license

	if kernel_is ge 2 6 29; then
		CONFIG_CHECK="LIB80211"
	else
		CONFIG_CHECK="IEEE80211 IEEE80211_CRYPT_TKIP"
	fi
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} M=${S}"
	BUILD_TARGETS="wl.ko"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${PN}-5.10.79.10-hidden-essid.patch" \
		"${FILESDIR}/${P}-linux-2.6.29.patch" \
		"${FILESDIR}/${PN}-5.10.79.10-linux-2.6.30.patch"
}
