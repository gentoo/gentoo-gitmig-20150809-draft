# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroid/freedroid-1.0.2.ebuild,v 1.6 2004/06/04 06:50:47 mr_bones_ Exp $

inherit games flag-o-matic gcc

DESCRIPTION="Freedroid - a Paradroid clone"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="oggvorbis"

DEPEND=">=media-libs/libsdl-1.2.3
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image
	media-libs/sdl-mixer
	oggvorbis? ( media-libs/libvorbis )"

src_compile() {
	[ "$(gcc-fullversion)" == "3.2.3" ] && filter-mfpmath sse
	games_src_compile
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
