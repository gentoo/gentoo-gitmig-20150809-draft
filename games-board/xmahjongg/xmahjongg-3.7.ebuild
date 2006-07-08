# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmahjongg/xmahjongg-3.7.ebuild,v 1.3 2006/07/08 23:04:12 kumba Exp $

inherit games

DESCRIPTION="friendly GUI version of xmahjongg"
HOMEPAGE="http://www.lcdf.org/xmahjongg/"
SRC_URI="http://www.lcdf.org/xmahjongg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc ~ppc-macos x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libSM
				x11-libs/libX11 )
			virtual/x11 )
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
