# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook/omnibook-20080125.ebuild,v 1.1 2008/04/06 08:50:37 nelchael Exp $

inherit linux-mod eutils

DESCRIPTION="Linux kernel module for (but not limited to) HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omnibook"
# Revision 274 from upstream SVN repository
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~amd64 -ppc ~x86"
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
