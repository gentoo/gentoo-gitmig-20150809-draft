# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mpiblast/mpiblast-1.6.0.ebuild,v 1.1 2010/07/31 19:20:25 weaver Exp $

EAPI="2"

inherit eutils

DESCRIPTION="An MPI implementation of NCBI BLAST"
HOMEPAGE="http://www.mpiblast.org/"
SRC_URI="http://www.mpiblast.org/downloads/files/mpiBLAST-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS=""

# app-shells/tcsh
DEPEND="virtual/mpi
	=sci-biology/ncbi-tools-20090301"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-1.6.0"

src_prepare() {
	sed -i 's/if test "@ARCH@" == "normal"/if true/' "${S}"/Makefile.{am,in} || die
}

src_compile() {
	emake ncbi || die
	emake || die
}

src_install() {
	einstall || die
}
