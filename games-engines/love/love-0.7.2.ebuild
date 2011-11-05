# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/love/love-0.7.2.ebuild,v 1.1 2011/11/05 19:29:17 chithanh Exp $

EAPI=3

inherit games

DESCRIPTION="A framework for 2D games in Lua"
HOMEPAGE="http://love2d.org/"
SRC_URI="https://bitbucket.org/rude/${PN}/downloads/${P}-linux-src.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-games/physfs
	dev-lang/lua
	media-libs/devil
	media-libs/freetype
	media-libs/libmng
	media-libs/libmodplug
	media-libs/libsdl[joystick]
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-sound
	media-libs/tiff
	media-sound/mpg123
	virtual/opengl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-HEAD

DOCS=( "readme.txt" "changes.txt" )
