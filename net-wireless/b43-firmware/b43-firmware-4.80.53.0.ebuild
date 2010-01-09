# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/b43-firmware/b43-firmware-4.80.53.0.ebuild,v 1.1 2010/01/09 21:30:37 vapier Exp $

: ${B43_FIRMWARE_SRC_OBJ:=wl_apsta.o}

MY_P="broadcom-wl-${PV}"
DESCRIPTION="broadcom firmware for b43 and <=linux-2.6.24*"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/b43"
SRC_URI="http://downloads.openwrt.org/sources/${MY_P}.tar.bz2"

LICENSE="as-is"
SLOT="b43"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror binchecks strip"

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
