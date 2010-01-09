# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl5150-ucode/iwl5150-ucode-8.24.2.2.ebuild,v 1.2 2010/01/09 11:26:55 hanno Exp $

MY_PN="iwlwifi-5150-ucode"

DESCRIPTION="Intel (R) Wireless WiFi Link 5150-AGN ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${PV}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	true;
}

src_install() {
	insinto /lib/firmware
	doins "${S}/iwlwifi-5150-2.ucode"

	dodoc README* || die "dodoc failed"
}
