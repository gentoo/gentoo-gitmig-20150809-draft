# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cgterm/cgterm-1.6.ebuild,v 1.1 2004/12/11 18:07:46 kloeri Exp $

DESCRIPTION="Connect to C64 telnet BBS's with the correct colours and font"
HOMEPAGE="http://www.paradroid.net/cgterm/"
SRC_URI="http://www.paradroid.net/cgterm/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2.5"

src_compile() {
	emake CFLAGS="${CFLAGS} `sdl-config --cflags` -DPREFIX=\\\"/usr\\\"" || die
}

src_install() {
	mkdir "${D}/usr"
	emake install PREFIX="${D}/usr" LDFLAGS="`sdl-config --libs`" || die
	rmdir "${D}/usr/etc"
}
