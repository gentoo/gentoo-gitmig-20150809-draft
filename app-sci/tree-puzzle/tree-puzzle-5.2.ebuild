# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tree-puzzle/tree-puzzle-5.2.ebuild,v 1.1 2004/07/20 20:56:20 ribosome Exp $

DESCRIPTION="Maximum likelihood analysis for nucleotide, amino acid, and two-state data."
HOMEPAGE="http://www.tree-puzzle.de"
SRC_URI="http://www.tree-puzzle.de/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="mpi"

DEPEND="virtual/glibc
	mpi? ( sys-cluster/lam-mpi )"

pkg_setup () {
	use mpi && [ ${CC} = icc ] && die "The parallelized version of tree-puzzle cannot be compiled using icc.
    Either disable the \"mpi\" USE flag to compile only the non-parallelized
    version of the program, or use gcc as your compiler (CC=\"gcc\")."
}

src_compile() {
	econf || die
	cd ${S}/src
	if ! use mpi; then
		sed -i -e 's:bin_PROGRAMS = puzzle$(EXEEXT) ppuzzle:bin_PROGRAMS = puzzle :' Makefile
		sed -i -e 's:DIST_SOURCES = $(ppuzzle_SOURCES) $(puzzle_SOURCES):DIST_SOURCES = $(puzzle_SOURCES):' Makefile
	fi
	cd {S}
	emake || die
}

src_install() {
	dobin src/puzzle
	use mpi && dobin src/ppuzzle
	dodoc AUTHORS ChangeLog README

	# User manual
	insinto /usr/share/doc/${PF}
	doins doc/tree-puzzle.pdf

	# Example data files
	insinto /usr/share/${PN}/data
	rm data/Makefile*
	doins data/*
}
