# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity-ng/lincity-ng-1.1.2.ebuild,v 1.6 2009/01/09 14:27:10 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="city/country simulation game for X and opengl"
HOMEPAGE="http://lincity-ng.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/opengl
	dev-libs/libxml2
	media-libs/libsdl
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/sdl-gfx
	dev-games/physfs"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/ftjam"

src_compile() {
	jam || die "jam failed"
}

src_install() {
	jam -sDESTDIR="${D}" \
		 -sappdocdir="/usr/share/doc/${PF}" \
		 -sapplicationsdir="/usr/share/applications" \
		 -spixmapsdir="/usr/share/pixmaps" \
		 install \
		 || die "jam install failed"
	prepalldocs
	prepgamesdirs
}
