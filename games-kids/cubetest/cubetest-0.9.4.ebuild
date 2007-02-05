# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/cubetest/cubetest-0.9.4.ebuild,v 1.4 2007/02/05 21:24:17 mr_bones_ Exp $

inherit qt4 eutils games

DESCRIPTION="A program to train your spatial insight"
HOMEPAGE="http://www.vandenoever.info/software/cubetest/"
SRC_URI="http://www.vandenoever.info/software/cubetest/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="$(qt4_min_version 4)"

pkg_setup() {
	games_pkg_setup
	if has_version ">=x11-libs/qt-4.2.2" ; then
		if ! built_with_use x11-libs/qt qt3support ; then
			eerror "${PN} requires qt3support"
			die "rebuild >=x11-libs/qt-4.2.2 with the qt3support USE flag"
		fi
	fi
}

src_unpack() {
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
