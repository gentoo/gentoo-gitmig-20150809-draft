# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalw-mpi/clustalw-mpi-0.13.ebuild,v 1.2 2006/01/04 23:32:49 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="A parallel (MPI) implemention of the Clustal-W general purpose multiple alignment program"
LICENSE="public-domain"
HOMEPAGE="http://web.bii.a-star.edu.sg/~kuobin/clustalw-mpi/"
SRC_URI="http://web.bii.a-star.edu.sg/~kuobin/${PN}/${P}.tar.gz"

SLOT="0"
IUSE="mpi_njtree static_pairalign"
KEYWORDS="~x86"

DEPEND="virtual/mpi"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s/CFLAGS  = -c -O3/CFLAGS = -c ${CFLAGS}/" \
		-e "s/LFLAGS	= -lm/LFLAGS = -lm ${CFLAGS}/" -i Makefile || \
			die "Failed to apply CFLAGS."
	if use mpi_njtree; then
		sed -e "s/TREES_FLAG/#TREES_FLAG/" -i Makefile || \
			die "Failed to configure MPI code for NJ trees."
	fi
	if use static_pairalign; then
		sed -e "s/DDYNAMIC_SCHEDULING/DSTATIC_SCHEDULING/" -i Makefile || \
			die "Failed to configure static scheduling for pair alignments."
	fi
}

src_compile() {
	emake || die
}

src_install() {
	dobin clustalw-mpi || die
	newdoc README.${PN} README || die
}
