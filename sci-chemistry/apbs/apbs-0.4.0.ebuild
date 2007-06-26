# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/apbs/apbs-0.4.0.ebuild,v 1.6 2007/06/26 02:39:25 mr_bones_ Exp $

inherit eutils fortran

DESCRIPTION=" Software for evaluating the electrostatic properties of nanoscale biomolecular systems"
LICENSE="GPL-2"
HOMEPAGE="http://agave.wustl.edu/apbs/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
IUSE="blas mpi"
KEYWORDS="~ppc ~x86 ~amd64"

DEPEND="blas? ( virtual/blas )
		sys-libs/readline
		dev-libs/maloc
		mpi? ( virtual/mpi )"

FORTRAN="g77 gfortran"

pkg_setup() {
	fortran_pkg_setup

	# the configure script has a weird MPI related behaviour:
	# if maloc was compiled with mpi, apbs requires mpi as
	# well and will bomb otherwise; if maloc was compiled
	# without mpi, apbs will silently disable mpi even if
	# USE="mpi" is forced
	if use mpi; then
		if ! built_with_use dev-libs/maloc mpi; then
			die 'USE="mpi" requires dev-libs/maloc built with mpi'
		fi
	else
		if built_with_use dev-libs/maloc mpi; then
			die 'USE="-mpi" requires dev-libs/maloc built without mpi'
		fi
	fi
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-examples-gentoo.patch
	epatch "${FILESDIR}"/${PN}-gcc4-gentoo.patch
}

src_compile() {
	# use blas
	use blas && local myconf="--with-blas=-lblas"

	use mpi && myconf="${myconf} --with-mpiinc=/usr/include"

	# configure
	econf ${myconf} || die "configure failed"

	# build
	make || die "make failed"
}

src_install() {

	# install apbs binary
	dobin bin/apbs || die "failed to install apbs binary"

	# fix up and install examples
	find ./examples -name 'test.sh' -exec rm -f {} \; || \
		die "Failed to remove test.sh files"
	find ./examples -name 'Makefile*' -exec rm -f {} \; || \
		die "Failed to remove Makefiles"
	insinto /usr/share/doc/${PF}/examples
	doins -r examples/* || die "failed to install examples"

	# install docs
	insinto /usr/share/doc/${PF}/html/programmer
	doins doc/html/programmer/* || die "failed to install html docs"

	insinto /usr/share/doc/${PF}/html/tutorial
	doins doc/html/tutorial/* || die "failed to install html docs"

	insinto /usr/share/doc/${PF}/html/user-guide
	doins doc/html/user-guide/* || die "failed to install html docs"
}
