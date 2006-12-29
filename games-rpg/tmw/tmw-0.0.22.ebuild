# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.0.22.ebuild,v 1.2 2006/12/29 04:57:34 mr_bones_ Exp $

inherit eutils games

MUSIC=tmwmusic-0.0.20
DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${P}.tar.gz
	mirror://sourceforge/themanaworld/${MUSIC}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl"

DEPEND=">=dev-games/physfs-1.0.0
	opengl? ( virtual/opengl )
	dev-libs/libxml2
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-net
	net-misc/curl
	>=dev-games/guichan-0.5.0"

pkg_setup() {
	games_pkg_setup
	if ! built_with_use dev-games/guichan sdl ; then
		eerror "dev-games/guichan needs to be built with USE=sdl"
		die "please re-emerge dev-games/guichan with USE=sdl"
	fi
	if ! built_with_use media-libs/sdl-mixer vorbis ; then
		eerror "media-libs/sdl-mixer needs to be built with USE=vorbis"
		die "please re-emerge media-libs/sdl-mixer with USE=vorbis"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.0.12-desktop.patch
}

src_compile() {
	egamesconf $(use_with opengl) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	cd ${WORKDIR}
	insinto "${GAMES_DATADIR}"/${PN}/data/music
	doins ${MUSIC}/data/music/*.ogg || die
	newdoc ${MUSIC}/README README.music
	prepgamesdirs
}
