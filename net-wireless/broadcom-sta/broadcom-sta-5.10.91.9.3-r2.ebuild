# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/broadcom-sta/broadcom-sta-5.10.91.9.3-r2.ebuild,v 1.1 2009/12/07 15:47:15 matsuu Exp $

inherit eutils linux-mod

DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver."
HOMEPAGE="http://www.broadcom.com/support/802.11/linux_sta.php"
SRC_BASE="http://www.broadcom.com/docs/linux_sta/hybrid-portsrc-x86_"
SRC_URI="x86? ( ${SRC_BASE}32-v${PV}.tar.gz )
	amd64? ( ${SRC_BASE}64-v${PV}.tar.gz )"

LICENSE="Broadcom"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/linux-sources-2.6.22"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

MODULE_NAMES="wl(net/wireless)"
MODULESD_WL_ALIASES=("wlan0 wl")

PROPERTIES="interactive"

pkg_setup() {
	check_license

	CONFIG_CHECK="~!B43 ~!SSB"
	if kernel_is ge 2 6 31; then
		CONFIG_CHECK="${CONFIG_CHECK} LIB80211"
	elif kernel_is ge 2 6 29; then
		CONFIG_CHECK="${CONFIG_CHECK} LIB80211 COMPAT_NET_DEV_OPS"
	else
		CONFIG_CHECK="${CONFIG_CHECK} IEEE80211 IEEE80211_CRYPT_TKIP"
	fi
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} M=${S}"
	BUILD_TARGETS="wl.ko"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-5.10.91.9-license.patch" \
		"${FILESDIR}/${P}-linux-2.6.32.patch"
}
