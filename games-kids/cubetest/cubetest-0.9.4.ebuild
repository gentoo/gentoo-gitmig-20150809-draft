# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/cubetest/cubetest-0.9.4.ebuild,v 1.5 2008/06/10 00:40:13 mr_bones_ Exp $

EAPI=1
inherit eutils games

DESCRIPTION="A program to train your spatial insight"
HOMEPAGE="http://www.vandenoever.info/software/cubetest/"
SRC_URI="http://www.vandenoever.info/software/cubetest/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/qt:4"

pkg_setup() {
	games_pkg_setup
	if ! built_with_use --missing true "x11-libs/qt:4" qt3support ; then
		eerror "${PN} requires qt3support"
		die "rebuild x11-libs/qt:4 with the qt3support USE flag"
	fi
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
