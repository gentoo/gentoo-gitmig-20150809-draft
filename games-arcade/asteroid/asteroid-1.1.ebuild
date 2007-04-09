# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/asteroid/asteroid-1.1.ebuild,v 1.4 2007/04/09 21:47:34 welp Exp $

inherit games

DESCRIPTION="A modern version of the arcade classic that uses OpenGL and GLUT"
HOMEPAGE="http://chaoslizard.sourceforge.net/asteroid/"
SRC_URI="mirror://sourceforge/chaoslizard/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/opengl
	virtual/glut
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc asteroid-{authors,changes,readme}.txt
	prepgamesdirs
}
