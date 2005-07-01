# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadros/quadros-0.1.ebuild,v 1.3 2005/07/01 15:04:16 caleb Exp $

inherit kde games
need-qt 3

DESCRIPTION="An implementation of the Tetris game with team multiplayer ability"
HOMEPAGE="http://quadros.sourceforge.net/"
SRC_URI="mirror://sourceforge/quadros/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

src_unpack() {
	kde_src_unpack
}

src_compile() {
	kde_src_compile nothing
	${QTDIR}/bin/qmake -project -o quadros.pro
	# Need generating .pro file from scratch
	# because shipped src/quadros.pro is corrupted
	# and shipped configure scripts requires pre-installed kde-libs
	# and other stuff like dcopidl,...
	# which are not required by game
	echo "QMAKE_CXXFLAGS += ${CXXFLAGS}" >> quadros.pro
	echo "CONFIG += qt thread warn_on release" >> quadros.pro
	${QTDIR}/bin/qmake -o Makefile quadros.pro
	emake || die "emake failed"
}

src_install() {
	dogamesbin quadros || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog TODO NEWS README
	prepgamesdirs
}
