# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/epix/epix-1.0.0.ebuild,v 1.2 2005/02/04 23:22:30 cryos Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/epix/${P}_complete.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/tetex"

RDEPEND="app-shells/bash
		>=sys-apps/sed-4"

src_compile() {
	filter-flags -O1 -O2 -O3 -Os
	make CXX="$(tc-getCXX)" CFLAGS="-c -Wall ${CXXFLAGS}" prefix="${D}/usr" all || die "emake failed."
	echo > README.gentoo -e "The full documentation is well hidden in the epix*howto.ps.gz-file in the tutorial subdirectory"
}

src_test() {
	make CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" prefix="${D}/usr" test
}

src_install() {
	make CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" prefix="${D}/usr" install || die
	dodoc README.gentoo
	cd ${D}/usr/share/${PN}
	rm notes/COPYING
	rm notes/INSTALL
	dodoc notes/*
	rm -rf notes
	insinto /usr/share/doc/${PF}/tutorial
	doins tutorial/*
	insinto /usr/share/doc/${PF}/tutorial/contrib
	doins tutorial/contrib/*
	rm -rf tutorial
}
