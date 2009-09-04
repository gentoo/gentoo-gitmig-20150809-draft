# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/raxml/raxml-7.0.4.ebuild,v 1.1 2009/09/04 03:04:43 weaver Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A Program for Sequential, Parallel & Distributed Inference of Large Phylogenetic Trees"
HOMEPAGE="http://icwww.epfl.ch/~stamatak/index-Dateien/Page443.htm"
SRC_URI="http://icwww.epfl.ch/~stamatak/index-Dateien/software/RAxML-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="+mpi +threads"
KEYWORDS="~amd64 ~x86"

DEPEND="mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/RAxML-${PV}"

src_prepare() {
	sed -i -e 's/CFLAGS =/CFLAGS := ${CFLAGS}/' \
		-e 's/CC = gcc/CC = '$(tc-getCC)'/' \
		Makefile.* || die
}

src_compile() {
	emake -f Makefile.gcc || die
	if use mpi; then emake -f Makefile.MPI clean && emake -f Makefile.MPI || die; fi
	if use threads; then emake -f Makefile.PTHREADS clean && emake -f Makefile.PTHREADS || die; fi
}

src_install() {
	dobin raxmlHPC || die
	if use mpi; then dobin raxmlHPC-MPI || die; fi
	if use threads; then dobin raxmlHPC-PTHREADS || die; fi
}
