# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/apbs/apbs-0.5.0.ebuild,v 1.4 2009/02/05 05:44:50 darkside Exp $

inherit eutils fortran

MY_P="${P}-source-2"
S="${WORKDIR}"/"${MY_P}"

DESCRIPTION=" Software for evaluating the electrostatic properties of nanoscale biomolecular systems"
LICENSE="GPL-2"
HOMEPAGE="http://apbs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
IUSE="blas mpi"
KEYWORDS="~ppc ~x86 ~amd64"

DEPEND="blas? ( virtual/blas )
		sys-libs/readline
		mpi? ( virtual/mpi )"

FORTRAN="g77 gfortran"

pkg_setup() {
	# It is important that you use the same compiler to compile
	# APBS that you used when compiling MPI.
	fortran_pkg_setup
}

src_compile() {

	# use blas
	use blas && local myconf="--with-blas=-lblas"

	use mpi && myconf="${myconf} --with-mpiinc=/usr/include"

	econf ${myconf} || die "configure failed"

	# build
	make DESTDIR="${D}" || die "make failed"
}

src_install() {

	# install apbs binary
	dobin bin/apbs || die "failed to install apbs binary"

	# remove useless files and install docs
	find ./examples -name 'test.sh' -exec rm -f {} \; || \
		die "Failed to remove test.sh files"
	find ./examples -name 'Makefile*' -exec rm -f {} \; || \
		die "Failed to remove Makefiles"
	find ./tools -name 'Makefile*' -exec rm -f {} \; || \
		die "Failed to remove Makefiles"

	dohtml -r doc/index.html doc/programmer doc/tutorial \
		doc/user-guide doc/license || \
			die "Failed to install html docs"

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/* || \
		die "Failed to install examples"

	insinto /usr/share/${PF}/tools
	doins -r tools/* || die "failed to install tools"

}
