# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroid/freedroid-1.0.2.ebuild,v 1.10 2007/02/06 18:38:15 mr_bones_ Exp $

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="Freedroid - a Paradroid clone"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="vorbis"

DEPEND=">=media-libs/libsdl-1.2.3
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image
	media-libs/sdl-mixer
	vorbis? ( media-libs/libvorbis )"

src_compile() {
	[ "$(gcc-fullversion)" == "3.2.3" ] && filter-mfpmath sse
	games_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	newicon graphics/paraicon.bmp ${PN}.bmp
	make_desktop_entry freedroid Freedroid /usr/share/pixmaps/${PN}.bmp
	prepgamesdirs
}
