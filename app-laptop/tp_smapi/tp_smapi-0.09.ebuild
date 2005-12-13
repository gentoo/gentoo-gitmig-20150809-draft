# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tp_smapi/tp_smapi-0.09.ebuild,v 1.1 2005/12/13 20:40:18 brix Exp $

inherit linux-mod

DESCRIPTION="IBM ThinkPad SMAPI BIOS driver"
HOMEPAGE="http://tpctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/tpctl/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

BUILD_TARGETS="default"
MODULE_NAMES="tp_smapi(extra:)"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 13; then
		eerror
		eerror "${P} requires Linux kernel 2.6.13 or above."
		eerror
		die "Unsupported kernel version"
	fi

	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES README
}
