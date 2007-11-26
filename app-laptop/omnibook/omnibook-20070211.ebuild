# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook/omnibook-20070211.ebuild,v 1.5 2007/11/26 16:10:13 s4t4n Exp $

inherit linux-mod eutils

MY_PV="2.${PV}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Linux kernel module for (but not limited to) HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omnibook"
SRC_URI="mirror://sourceforge/omnibook/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 -ppc x86"
IUSE=""
S=${WORKDIR}/${MY_P}

MODULE_NAMES="omnibook(char:)"
BUILD_TARGETS=" "

pkg_setup() {
	if ! kernel_is le 2 6 11; then
		die "This version of omnibook cannot be built on a kernel > 2.6.11!"
	fi

	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL=${KV_MAJOR}.${KV_MINOR} KSRC=${KV_DIR}"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	dosbin misc/obtest/obtest
	dodoc doc/*
	docinto misc
	dodoc misc/*.patch misc/*.txt
	docinto hotkeys
	dodoc misc/hotkeys/*

	linux-mod_src_install
}
