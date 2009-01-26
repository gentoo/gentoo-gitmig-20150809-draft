# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.0.28.ebuild,v 1.1 2009/01/26 17:58:21 mr_bones_ Exp $

EAPI=2
inherit eutils games

MUSIC=tmwmusic-0.0.20
DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${P}.tar.gz
	mirror://sourceforge/themanaworld/${MUSIC}.tar.gz"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls opengl"
PATCHES=( "${FILESDIR}"/${P}-desktop.patch )

RDEPEND=">=dev-games/physfs-1.0.0
	opengl? ( virtual/opengl )
	dev-libs/libxml2
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng
	>=dev-games/guichan-0.8.1[sdl]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		$(use_enable nls) \
		$(use_with opengl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}"/${PN}/data/music
	doins ${MUSIC}/data/music/*.ogg || die
	newdoc ${MUSIC}/README README.music
	prepgamesdirs
}
