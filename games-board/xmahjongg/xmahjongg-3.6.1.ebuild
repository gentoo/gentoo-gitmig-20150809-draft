# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmahjongg/xmahjongg-3.6.1.ebuild,v 1.2 2004/01/31 05:57:47 mr_bones_ Exp $

inherit games

DESCRIPTION="friendly GUI version of xmahjongg"
HOMEPAGE="http://www.lcdf.org/xmahjongg/"
SRC_URI="http://www.lcdf.org/xmahjongg/${P}.tar.gz"

KEYWORDS="x86 amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib"

src_compile() {
	egamesconf --with-x
	emake || die "emake failed"
}

src_install() {
	egamesinstall
	prepgamesdirs
}
