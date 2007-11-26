# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook-svn/omnibook-svn-20071231.ebuild,v 1.1 2007/11/26 07:40:03 s4t4n Exp $

inherit linux-mod subversion

ESVN_REPO_URI="https://omnibook.svn.sourceforge.net/svnroot/omnibook/omnibook/trunk"
ESVN_PROJECT="omnibook"

DESCRIPTION="Linux kernel module for (but not limited to) HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omnibook"
SRC_URI=""

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 -ppc"
IUSE=""

MODULE_NAMES="omnibook(char:)"
BUILD_TARGETS=" "

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL=${KV_MAJOR}.${KV_MINOR} KSRC=${KV_DIR}"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	dodoc doc/*
	docinto misc
	dodoc misc/*.patch misc/*.txt
	docinto hotkeys
	dodoc misc/hotkeys/*

	linux-mod_src_install
}
