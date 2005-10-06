# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils

DESCRIPTION="utilities to change speech parameters in speakup"
HOMEPAGE="http://www.linux-speakup.org"
SRC_URI="ftp://linux-speakup.org/pub/linux/goodies/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.4"

src_compile() {
	make || die"Compile Failed"
}

src_install() {
	dobin speakupcfg speakupctl
	dodoc Changelog README
}
