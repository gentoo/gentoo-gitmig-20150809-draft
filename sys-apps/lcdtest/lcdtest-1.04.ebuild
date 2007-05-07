# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdtest/lcdtest-1.04.ebuild,v 1.1 2007/05/07 22:17:29 chainsaw Exp $

DESCRIPTION="Displays test patterns to spot dead/hot pixels on LCD screens"
HOMEPAGE="http://www.brouhaha.com/~eric/software/lcdtest/"
SRC_URI="http://www.brouhaha.com/~eric/software/lcdtest/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
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
