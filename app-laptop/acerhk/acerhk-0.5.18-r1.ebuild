# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acerhk/acerhk-0.5.18-r1.ebuild,v 1.3 2005/01/02 10:40:29 genstef Exp $

inherit linux-mod eutils

DESCRIPTION="Hotkey driver for some Acer and Acer-like laptops"
HOMEPAGE="http://www.informatik.hu-berlin.de/~tauber/acerhk/"
SRC_URI="http://www.informatik.hu-berlin.de/~tauber/acerhk/archives/acerhk-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
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
