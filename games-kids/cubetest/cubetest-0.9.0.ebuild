# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/cubetest/cubetest-0.9.0.ebuild,v 1.2 2004/03/24 19:26:38 jhuebel Exp $

inherit kde
need-kde 3

DESCRIPTION="A program to train your spatial insight"
HOMEPAGE="http://www.vandenoever.info/software/cubetest/"
SRC_URI="http://www.vandenoever.info/software/cubetest/${P}.tar.bz2"

KEYWORDS="x86 amd64"
LICENSE="GPL-2"
SLOT="0"

export DO_NOT_COMPILE="fun"

DEPEND="${DEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i \
		-e '/^bin_PROGRAMS/ s/testqg//' "${S}/src/Makefile.in" \
			|| die "sed src/Makefile.in failed"
}
