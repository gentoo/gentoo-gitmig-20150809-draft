# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl4965-ucode/iwl4965-ucode-228.57.2.21.ebuild,v 1.4 2009/01/22 11:57:51 pva Exp $

MY_PN="iwlwifi-4965-ucode"

DESCRIPTION="Intel (R) Wireless WiFi Link 4965AGN ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${PV}.tgz"

LICENSE="Intel"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"

S=${WORKDIR}/${MY_PN}-${PV}

src_compile() {
	true;
}

src_install() {
	insinto /lib/firmware
	doins iwlwifi-4965-2.ucode || die
	dodoc README* || die "dodoc failed"
}

pkg_postinst() {
	elog "This version ofucode works only with kernels >=2.6.27. In case you have"
	elog "older kernel, please, mask net-wireless/iwl4965-unicode:1. For more"
	elog "information take a look at bugs.gentoo.org/235007"
}
