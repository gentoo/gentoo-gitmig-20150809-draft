# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/b43-firmware/b43-firmware-4.174.64.19.ebuild,v 1.2 2011/05/09 14:12:49 nelchael Exp $

: ${B43_FIRMWARE_SRC_OBJ:=wl_apsta.o}

# The tarball is mislabeled as "4.178.10.4", but it is actually 4.174.64.19
MY_P="broadcom-wl-4.178.10.4"
DESCRIPTION="broadcom firmware for b43 LP PHY and >=linux-2.6.32"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/b43"
SRC_URI="http://downloads.openwrt.org/sources/${MY_P}.tar.bz2"

LICENSE="as-is"
SLOT="b43"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror binchecks strip"

DEPEND=">=net-wireless/b43-fwcutter-013"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	mkdir ebuild-output
	b43-fwcutter -w ebuild-output $(find -name ${B43_FIRMWARE_SRC_OBJ}) || die
}

src_install() {
	insinto /lib/firmware
	doins -r ebuild-output/* || die
}
