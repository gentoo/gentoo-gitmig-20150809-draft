# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/cubetest/cubetest-0.9.4.ebuild,v 1.6 2008/06/30 23:15:04 nyhm Exp $

EAPI=1
inherit eutils qt4 games

DESCRIPTION="A program to train your spatial insight"
HOMEPAGE="http://www.vandenoever.info/software/cubetest/"
SRC_URI="http://www.vandenoever.info/software/cubetest/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="|| (
		( x11-libs/qt-gui:4 x11-libs/qt-qt3support:4 )
		x11-libs/qt:4
	)"

pkg_setup() {
	games_pkg_setup
	QT4_BUILT_WITH_USE_CHECK="qt3support" qt4_pkg_setup
}

src_unpack() {
	local i

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	for i in $(find  src/ -iname *_moc.cpp) ; do
		moc ${i/_moc.cpp/.h} -o $i || die
	done
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
