# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/mcs7780/mcs7780-0.2_alpha3.ebuild,v 1.1 2005/11/04 21:54:25 sbriesen Exp $

inherit eutils linux-mod

MY_P="${PN}-${PV/_alpha/alpha.}"

DESCRIPTION="Driver for MosChip MCS7780 USB-IrDA bridge chip"
HOMEPAGE="http://www.ee.pw.edu.pl/~stelmacl/"
SRC_URI="http://www.ee.pw.edu.pl/~stelmacl/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! kernel_is 2 6; then
		die "This package works only with 2.6 kernel!"
	fi
	CONFIG_CHECK="IRDA USB"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
	BUILD_TARGETS="default"
	MODULE_NAMES="mcs7780(net/irda)"
	MODULESD_MCS7780_ENABLED="yes"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	convert_to_m "Makefile"
	# comment out some debug-infos (floods syslog)
	sed -i -e "s:^\([^/]*\)\(info(.*__FUNCTION__\):\1//\2¹:g" mcs7780.c
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo
	einfo "This driver is an *alpha* driver! Expect everything! ;-)"
	einfo
	einfo "For more informations about this driver, have a look"
	einfo "at this thread on the Linux-Kernel mailing list:"
	einfo
	einfo "http://www.ussg.iu.edu/hypermail/linux/kernel/0505.3/0377.html"
	einfo
}
