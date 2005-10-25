# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/asteroid/asteroid-1.0.4.ebuild,v 1.1 2005/10/25 02:12:55 mr_bones_ Exp $

inherit games

DESCRIPTION="A modern version of the arcade classic that uses OpenGL and GLUT"
HOMEPAGE="http://chaoslizard.sourceforge.net/asteroid/"
SRC_URI="mirror://sourceforge/chaoslizard/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glut
	virtual/glu"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc asteroid-{authors,changes,readme}.txt
	prepgamesdirs
}
