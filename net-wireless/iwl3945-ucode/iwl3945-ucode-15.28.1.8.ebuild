# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl3945-ucode/iwl3945-ucode-15.28.1.8.ebuild,v 1.4 2009/04/19 14:43:12 maekke Exp $

MY_P="iwlwifi-3945-ucode-${PV}"

DESCRIPTION="Intel (R) PRO/Wireless 3945ABG Network Connection ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_P}.tgz"

LICENSE="Intel"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	true;
}

src_install() {
	insinto /lib/firmware
	doins iwlwifi-3945-1.ucode || die
	dodoc README*
}

pkg_postinst() {
	elog
	elog "This version of ucode works only with kernels <2.6.29-rc1. For newer"
	elog "kernels use newer ucode:"
	elog "emerge ${CATEGORY}/${PN}:1"
	elog "For more information take a look at bugs.gentoo.org/246045"
	elog
}
