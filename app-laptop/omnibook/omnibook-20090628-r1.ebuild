# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook/omnibook-20090628-r1.ebuild,v 1.3 2010/06/29 09:15:39 fauli Exp $

EAPI="2"

inherit eutils linux-mod

DESCRIPTION="Linux kernel module for (but not limited to) HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omnibook"
# Revision 280 from upstream SVN repository
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="amd64 -ppc x86"
IUSE=""

MODULE_NAMES="omnibook(char:)"
BUILD_TARGETS=" "

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL=${KV_MAJOR}.${KV_MINOR} KSRC=${KV_DIR}"
}

src_prepare() {
	epatch  "${FILESDIR}/remove_owner.patch"
	epatch  "${FILESDIR}/backlight-2.6.34-${P}.patch"
}

src_install() {
	dodoc doc/*
	docinto misc
	dodoc misc/*.patch misc/*.txt
	docinto hotkeys
	dodoc misc/hotkeys/*

	linux-mod_src_install
}
