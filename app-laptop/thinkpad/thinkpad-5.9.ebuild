# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/thinkpad/thinkpad-5.9.ebuild,v 1.1 2006/02/18 13:20:14 steev Exp $

inherit eutils linux-mod

DESCRIPTION="Thinkpad system control kernel modules"

HOMEPAGE="http://tpctl.sourceforge.net"
SRC_URI="mirror://sourceforge/tpctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

BUILD_PARAMS="KSRC=${KV_DIR}"

MODULESD_THINKPAD_DOCS="README"

pkg_setup() {
	linux-info_pkg_setup

	case ${KV_MINOR} in
		4)
			BUILD_TARGETS="all"
			;;
		6)
			BUILD_TARGETS="default"
			;;
		*)
			die "Unsupported kernel version."
			;;
	esac

	MODULE_NAMES="thinkpad(thinkpad:${S}/${KV_MAJOR}.${KV_MINOR}/drivers)
				smapi(thinkpad:${S}/${KV_MAJOR}.${KV_MINOR}/drivers)
				superio(thinkpad:${S}/${KV_MAJOR}.${KV_MINOR}/drivers)
				rtcmosram(thinkpad:${S}/${KV_MAJOR}.${KV_MINOR}/drivers)"

	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install

	dodoc AUTHORS ChangeLog SUPPORTED-MODELS TECHNOTES

	doman man/*
}
