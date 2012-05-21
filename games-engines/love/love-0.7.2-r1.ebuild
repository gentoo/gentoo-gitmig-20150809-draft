# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/love/love-0.7.2-r1.ebuild,v 1.1 2012/05/21 21:30:55 chithanh Exp $

EAPI=3

inherit base games

DESCRIPTION="A framework for 2D games in Lua"
HOMEPAGE="http://love2d.org/"
SRC_URI="mirror://bitbucket/rude/${PN}/downloads/${P}-linux-src.tar.gz"

LICENSE="ZLIB"
SLOT="0.7"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-games/physfs
	dev-lang/lua
	media-libs/devil[mng,tiff]
	media-libs/freetype
	media-libs/libmodplug
	media-libs/libsdl[joystick,opengl]
	media-libs/libvorbis
	media-libs/openal
	media-sound/mpg123
	virtual/opengl"
DEPEND="${RDEPEND}
	media-libs/libmng
	media-libs/tiff"

S=${WORKDIR}/${PN}-HEAD

DOCS=( "readme.txt" "changes.txt" )

src_install() {
	base_src_install
	if [[ "${SLOT}" != "0" ]]; then
		mv "${ED}${GAMES_BINDIR}"/${PN} \
			"${ED}${GAMES_BINDIR}"/${PN}-${SLOT} || die
	fi
}
