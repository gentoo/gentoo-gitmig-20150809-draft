# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scientificpython/scientificpython-2.6.ebuild,v 1.2 2006/10/17 04:14:04 dberkholz Exp $

MY_P=${P/scientificpython/ScientificPython}
S=${WORKDIR}/${MY_P}
DV=1034 # hardcoded download version

inherit distutils

IUSE="mpi"
DESCRIPTION="Scientific Module for Python"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${DV}/${MY_P}.tar.gz"
HOMEPAGE="http://dirac.cnrs-orleans.fr/ScientificPython/"
SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND="virtual/python
	>=dev-python/numeric-23.0
	>=sci-libs/netcdf-3.0
	mpi? ( virtual/mpi )"

src_compile() {
	distutils_src_compile
	if use mpi; then
		cd Src/MPI
		${python} compile.py
		dobin mpipython || die "dobin failed"
	fi
}

src_install() {
	distutils_src_install

	dodoc MANIFEST.in README* Doc/CHANGELOG Doc/*.pdf
	dohtml Doc/Reference/*
	docinto Examples; dodoc Examples/*
	docinto Examples/BSP; dodoc Examples/BSP/*
}
