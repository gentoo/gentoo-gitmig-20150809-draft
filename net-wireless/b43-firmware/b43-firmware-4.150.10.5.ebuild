# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/b43-firmware/b43-firmware-4.150.10.5.ebuild,v 1.2 2011/09/03 09:29:55 scarabeus Exp $

: ${B43_FIRMWARE_SRC_OBJ:=wl_apsta_mimo.o}

MY_P="broadcom-wl-${PV}"
DESCRIPTION="broadcom firmware for b43 and >=linux-2.6.25"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/b43"
SRC_URI="http://downloads.openwrt.org/sources/${MY_P}.tar.bz2"

LICENSE="as-is"
SLOT="b43"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror binchecks strip"

DEPEND=">=net-wireless/b43-fwcutter-012"
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
