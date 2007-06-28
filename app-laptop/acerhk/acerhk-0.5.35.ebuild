# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acerhk/acerhk-0.5.35.ebuild,v 1.3 2007/06/28 07:18:36 opfer Exp $

inherit linux-mod

DESCRIPTION="Hotkey driver for some Acer and Acer-like laptops"
HOMEPAGE="http://www.cakey.de/acerhk/"
SRC_URI="http://www.cakey.de/${PN}/archives/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="-ppc x86"
IUSE=""

MODULE_NAMES="acerhk(extra:)"
BUILD_TARGETS="all"

src_unpack()
{
	unpack ${A}
	cd ${S}
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELSRC=${KV_DIR} KERNELVERSION=${KV_FULL}"
}

src_install() {
	linux-mod_src_install
	dodoc README COPYING NEWS
	docinto doc
	dodoc doc/*
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "You can load the module:"
	elog "% modprobe acerhk poll=1"
	elog "If you need poll=1 you can set it permanently in /etc/modules.d/acerhk"
	elog
	elog "If you need more info about this driver you can read the README file"
	elog "% zmore /usr/share/doc/${PF}/README.gz"
}
