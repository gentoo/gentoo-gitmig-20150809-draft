# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/cubetest/cubetest-0.9.0.ebuild,v 1.6 2005/06/28 05:30:34 vapier Exp $

inherit kde

DESCRIPTION="A program to train your spatial insight"
HOMEPAGE="http://www.vandenoever.info/software/cubetest/"
SRC_URI="http://www.vandenoever.info/software/cubetest/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

export DO_NOT_COMPILE="fun"

DEPEND=""
need-kde 3

src_unpack() {
	unpack ${A}

	sed -i \
		-e '/^bin_PROGRAMS/ s/testqg//' "${S}/src/Makefile.in" \
			|| die "sed src/Makefile.in failed"
}
