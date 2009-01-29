# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroidrpg/freedroidrpg-0.11.1.ebuild,v 1.1 2009/01/29 03:59:16 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A modification of the classical Freedroid engine into an RPG"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl"

RDEPEND=">=media-libs/libsdl-1.2.3
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-net
	media-libs/sdl-mixer[vorbis]
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libX11
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_prepare() {
	find sound graphics -type f -print0 | xargs -0 chmod a-x
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable opengl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}/${GAMES_BINDIR}/"{croppy,pngtoico,gluem}
	newicon win32/w32icon2_64x64.png ${PN}.png
	make_desktop_entry freedroidRPG "Freedroid RPG"
	prepgamesdirs
}
