# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/cubetest/cubetest-0.9.0.ebuild,v 1.4 2004/06/24 22:51:01 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="A program to train your spatial insight"
HOMEPAGE="http://www.vandenoever.info/software/cubetest/"
SRC_URI="http://www.vandenoever.info/software/cubetest/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

export DO_NOT_COMPILE="fun"

DEPEND="${DEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i \
		-e '/^bin_PROGRAMS/ s/testqg//' "${S}/src/Makefile.in" \
			|| die "sed src/Makefile.in failed"
}
