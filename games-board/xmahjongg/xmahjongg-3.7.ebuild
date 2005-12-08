# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmahjongg/xmahjongg-3.7.ebuild,v 1.1 2005/12/08 21:48:00 mr_bones_ Exp $

inherit games

DESCRIPTION="friendly GUI version of xmahjongg"
HOMEPAGE="http://www.lcdf.org/xmahjongg/"
SRC_URI="http://www.lcdf.org/xmahjongg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE=""

DEPEND="virtual/x11
	media-libs/libpng
	sys-libs/zlib"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
