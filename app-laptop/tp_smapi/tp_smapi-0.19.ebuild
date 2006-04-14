# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tp_smapi/tp_smapi-0.19.ebuild,v 1.1 2006/04/14 11:48:03 brix Exp $

inherit linux-mod

DESCRIPTION="IBM ThinkPad SMAPI BIOS driver"
HOMEPAGE="http://tpctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/tpctl/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="hdaps"

BUILD_TARGETS="default"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 13; then
		eerror
		eerror "${P} requires Linux kernel 2.6.13 or above."
		eerror
		die "Unsupported kernel version"
	fi

	MODULE_NAMES="tp_base(extra:) tp_smapi(extra:)"
	BUILD_PARAMS="KSRC=${KV_DIR}"

	if use hdaps; then
		MODULE_NAMES="${MODULE_NAMES} hdaps(extra:)"
		BUILD_PARAMS="${BUILD_PARAMS} HDAPS=1"
	fi
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES README
}
