# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl1000-ucode/iwl1000-ucode-39.31.5.1.ebuild,v 1.2 2011/09/16 12:22:02 chainsaw Exp $

EAPI=4
MY_P="iwlwifi-1000-ucode-${PV}"

DESCRIPTION="Intel (R) Wireless WiFi Link 1000BGN ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_P}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /lib/firmware
	doins iwlwifi-1000-5.ucode
	dodoc README.iwlwifi-1000-ucode
}
