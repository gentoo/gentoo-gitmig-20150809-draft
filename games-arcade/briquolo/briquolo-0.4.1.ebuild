# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/briquolo/briquolo-0.4.1.ebuild,v 1.1 2003/10/22 17:13:32 mr_bones_ Exp $

inherit games

DESCRIPTION="Breakout with 3D representation based on OpenGL"
HOMEPAGE="http://briquolo.free.fr/en/index.html"
SRC_URI="http://briquolo.free.fr/download/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/libpng
	nls? ( sys-devel/gettext )"

IUSE="nls"

src_compile() {
	egamesconf `use_enable nls` || die
	emake                       || die "emake failed"
}

src_install() {
	egamesinstall                  || die
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	prepgamesdirs
}
