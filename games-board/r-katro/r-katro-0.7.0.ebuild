# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/r-katro/r-katro-0.7.0.ebuild,v 1.7 2006/04/23 06:38:10 mr_bones_ Exp $

inherit games

DESCRIPTION="3D puzzle game"
HOMEPAGE="http://f.rodrigo.free.fr/games/r-katro/r-katro.php"
SRC_URI="http://f.rodrigo.free.fr/r-tech/cmp/addon-module/link/link.php?games/r-katro/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nls"

DEPEND="=x11-libs/qt-3*
	virtual/glut"

src_compile() {
	egamesconf $(use_enable nls) || die
	mkdir src/moc src/helpviewer/moc
	emake CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
