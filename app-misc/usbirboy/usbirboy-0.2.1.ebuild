# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/usbirboy/usbirboy-0.2.1.ebuild,v 1.1 2006/06/13 21:43:35 zzam Exp $

inherit linux-mod

DESCRIPTION="Use home made infrared receiver connected via USB"
HOMEPAGE="http://usbirboy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}/usbirboykmod

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES="usbirboy(misc:${S})"
	BUILD_PARAMS="INCLUDE=${KV_DIR}"
	BUILD_TARGETS="default"
}

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-kernel-2.6.16.diff
}

src_install() {
	linux-mod_src_install

	dodoc README

	cd ${WORKDIR}/${P}/mcubin
	insinto /usr/share/${PN}
	doins usbirboy.s19
}

pkg_postinst() {
	linux-mod_pkg_postinstall
	einfo
	einfo "Firmware file has been installed to /usr/share/${PN}"
	einfo
}

