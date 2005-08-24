# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.0.15.ebuild,v 1.1 2005/08/24 02:46:48 vapier Exp $

inherit eutils games

DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opengl"

DEPEND=">=dev-games/physfs-1.0.0
	opengl? ( virtual/opengl )
	dev-libs/libxml2
	media-libs/sdl-mixer
	media-libs/sdl-image
	>=dev-games/guichan-0.4.0"

pkg_setup() {
	if ! built_with_use dev-games/guichan sdl ; then
		eerror "dev-games/guichan needs to be built with USE=sdl"
		die "please re-emerge guichan with USE=sdl"
	fi
	games_pkg_setup
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
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
