# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/briquolo/briquolo-0.4.2.ebuild,v 1.3 2004/06/18 18:20:34 jhuebel Exp $

inherit games

DESCRIPTION="Breakout with 3D representation based on OpenGL"
HOMEPAGE="http://briquolo.free.fr/en/index.html"
SRC_URI="http://briquolo.free.fr/download/${P}.tar.bz2"

KEYWORDS="x86 ~amd64"
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
