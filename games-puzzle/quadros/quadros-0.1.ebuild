# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadros/quadros-0.1.ebuild,v 1.8 2009/12/29 22:41:19 mr_bones_ Exp $

EAPI=2
inherit eutils qt3 games

DESCRIPTION="An implementation of the Tetris game with team multiplayer ability"
HOMEPAGE="http://quadros.sourceforge.net/"
SRC_URI="mirror://sourceforge/quadros/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/qt:3"

src_prepare() {
	touch src/multiplayer.ui
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_configure() {
	${QTDIR}/bin/qmake -project -o quadros.pro
	# Need generating .pro file from scratch
	# because shipped src/quadros.pro is corrupted
	# and shipped configure scripts requires pre-installed kde-libs
	# and other stuff like dcopidl,...
	# which are not required by game
	echo "QMAKE_CXXFLAGS += ${CXXFLAGS}" >> quadros.pro
	echo "CONFIG += qt thread warn_on release" >> quadros.pro
	eqmake3 quadros.pro -o Makefile 
}

src_install() {
	dogamesbin quadros || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog TODO NEWS README
	prepgamesdirs
}
