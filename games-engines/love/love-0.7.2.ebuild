# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/love/love-0.7.2.ebuild,v 1.3 2012/04/17 15:06:21 mgorny Exp $

EAPI=3

inherit games

DESCRIPTION="A framework for 2D games in Lua"
HOMEPAGE="http://love2d.org/"
SRC_URI="mirror://bitbucket/rude/${PN}/downloads/${P}-linux-src.tar.gz"

LICENSE="ZLIB"
SLOT="0"
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
