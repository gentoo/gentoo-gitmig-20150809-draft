# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/gltron/gltron-0.70.ebuild,v 1.1 2004/01/02 07:03:08 mr_bones_ Exp $

inherit games

DESCRIPTION="3d tron, just like the movie"
HOMEPAGE="http://gltron.sourceforge.net/"
SRC_URI="mirror://sourceforge/gltron/${P}-source.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
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
	dodoc ChangeLog README      || die "dodoc failed"
	dohtml *.html               || die "dohtml failed"
	prepgamesdirs
}
