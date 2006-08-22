# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.7.0.ebuild,v 1.1 2006/08/22 07:46:06 mr_bones_ Exp $

inherit games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="gtk"

RDEPEND="=x11-libs/gtk+-2*
	=x11-libs/gtkglext-1.0*
	virtual/opengl
	virtual/glut
	media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO README
	prepgamesdirs
}
