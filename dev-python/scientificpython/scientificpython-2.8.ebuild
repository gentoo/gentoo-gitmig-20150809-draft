# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scientificpython/scientificpython-2.8.ebuild,v 1.1 2008/12/08 23:01:45 bicatali Exp $

MY_PN=ScientificPython
DV=2309 # hardcoded download version

inherit eutils distutils

DESCRIPTION="Scientific Module for Python"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${DV}/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://dirac.cnrs-orleans.fr/ScientificPython/"
SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="mpi doc"

DEPEND="dev-python/numpy
	sci-libs/netcdf
	mpi? ( virtual/mpi )"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-mpi.patch
}

src_compile() {
	distutils_src_compile
	if use mpi; then
		cd Src/MPI
		PYTHONPATH=$(ls -d "${S}"/build/lib*) \
			"${python}" compile.py || die "compile mpi failed"
	fi
}

src_test() {
	cd "${S}"/build/lib*
	for t in "${S}"/Tests/*tests.py; do
		PYTHONPATH=. "${python}" ${t} || die "test $(basename ${t}) failed"
	done
}

src_install() {
	distutils_src_install
	# do not install bsp related stuff, since we don't compile the interface
	dodoc README README.MPI Doc/CHANGELOG || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins Examples/{demomodule.c,netcdf_demo.py} || die "doins examples failed"
	if use mpi; then
		dobin Src/MPI/mpipython || die "dobin failed"
		doins Examples/mpi.py || die "doins mpi example failed failed"
	fi
	if use doc; then
		dohtml Doc/Reference/* || die "dohtml failed"
	fi
}
