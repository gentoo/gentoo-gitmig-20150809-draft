# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/gltron/gltron-0.70.ebuild,v 1.4 2004/11/20 07:08:10 mr_bones_ Exp $

inherit games

DESCRIPTION="3d tron, just like the movie"
HOMEPAGE="http://gltron.sourceforge.net/"
SRC_URI="mirror://sourceforge/gltron/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	sys-libs/zlib
	media-libs/libpng
	>=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	media-libs/sdl-sound"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
	dohtml *.html
	prepgamesdirs
}
