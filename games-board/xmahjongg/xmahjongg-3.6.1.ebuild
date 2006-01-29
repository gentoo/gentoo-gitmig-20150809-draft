# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmahjongg/xmahjongg-3.6.1.ebuild,v 1.7 2006/01/29 21:28:01 joshuabaergen Exp $

inherit games

DESCRIPTION="friendly GUI version of xmahjongg"
HOMEPAGE="http://www.lcdf.org/xmahjongg/"
SRC_URI="http://www.lcdf.org/xmahjongg/${P}.tar.gz"

KEYWORDS="amd64 ppc ~ppc-macos x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="|| ( ( x11-libs/libSM
				x11-libs/libX11 )
			virtual/x11 )
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

src_compile() {
	egamesconf --with-x
	emake || die "emake failed"
}

src_install() {
	egamesinstall
	prepgamesdirs
}
