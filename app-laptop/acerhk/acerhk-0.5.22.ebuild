# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acerhk/acerhk-0.5.22.ebuild,v 1.2 2005/03/21 06:14:57 mr_bones_ Exp $

inherit linux-mod eutils

DESCRIPTION="Hotkey driver for some Acer and Acer-like laptops"
HOMEPAGE="http://www.informatik.hu-berlin.de/~tauber/acerhk/"
SRC_URI="http://www.informatik.hu-berlin.de/~tauber/acerhk/archives/acerhk-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

MODULE_NAMES="acerhk(extra:)"
BUILD_PARAMS="KERNELSRC=${KV_DIR} KERNELVERSION=${KV_FULL}"
BUILD_TARGETS="all"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	epatch ${FILESDIR}/${P}-redef-wireless.patch
}

src_install() {
	linux-mod_src_install
	dodoc README COPYING NEWS doc/*
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "You can load the module:"
	einfo "% modprobe acerhk poll=1"
	einfo "If you need poll=1 you can set it permanently in /etc/modules.d/acerhk"
	echo
	einfo "If you need more info about this driver you can read the README file"
	einfo "% zmore /usr/share/doc/${PN}-${PV}/README.gz"
}
