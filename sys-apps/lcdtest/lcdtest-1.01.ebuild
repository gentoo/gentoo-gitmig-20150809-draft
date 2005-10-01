# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdtest/lcdtest-1.01.ebuild,v 1.1 2005/10/01 22:48:31 chainsaw Exp $

DESCRIPTION="Displays test patterns to spot dead/hot pixels on LCD screens"
HOMEPAGE="http://www.brouhaha.com/~eric/software/lcdtest/"
SRC_URI="http://www.brouhaha.com/~eric/software/lcdtest/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND=">=media-libs/libsdl-1.2.7-r2
	>=media-libs/sdl-image-1.2.3-r1"
DEPEND="$RDEPEND
	>=media-libs/netpbm-10.28
	>=sys-apps/sed-4.1.4"

src_install() {
	dobin lcdtest
	dodoc README
}
