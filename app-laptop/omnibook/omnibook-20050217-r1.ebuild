# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook/omnibook-20050217-r1.ebuild,v 1.1 2005/06/12 16:28:33 genstef Exp $

inherit linux-mod eutils

MY_P="${PN}-${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Linux kernel module for HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omke"
SRC_URI="mirror://sourceforge/omke/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
IUSE=""
S="${WORKDIR}/${MY_P}"

MODULE_NAMES="omnibook(char:)"
BUILD_TARGETS=" "

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL=${KV_MAJOR}.${KV_MINOR} KSRC=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/omnibook-fix-obtest-segfault.patch
	convert_to_m Makefile
}

src_compile() {
	cd misc/obtest
	emake || die "make obtest failed"

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
