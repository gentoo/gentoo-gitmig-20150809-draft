# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl5000-ucode/iwl5000-ucode-8.24.2.12.ebuild,v 1.3 2009/10/21 12:17:39 maekke Exp $

MY_PN="iwlwifi-5000-ucode"
MY_PV="${PV/0/A}"

DESCRIPTION="Intel (R) Wireless WiFi Link 5100/5300 ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${MY_PV}.tgz"

LICENSE="Intel"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_compile() {
	true;
}

src_install() {
	insinto /lib/firmware
	doins "${S}/iwlwifi-5000-2.ucode"

	dodoc README* || die "dodoc failed"
}
