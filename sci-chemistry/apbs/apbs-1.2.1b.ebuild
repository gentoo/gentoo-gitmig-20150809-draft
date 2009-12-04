# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/apbs/apbs-1.2.1b.ebuild,v 1.1 2009/12/04 04:09:15 markusle Exp $

EAPI="2"

inherit eutils fortran autotools python versionator flag-o-matic

MY_PV=$(get_version_component_range 1-3)
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}"/"${MY_P}-source"

DESCRIPTION=" Software for evaluating the electrostatic properties of nanoscale biomolecular systems"
LICENSE="BSD"
HOMEPAGE="http://apbs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz"

SLOT="0"
IUSE="arpack blas doc mpi python openmp"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="dev-libs/maloc[mpi=]
	blas? ( virtual/blas )
	python? ( dev-lang/python )
	sys-libs/readline
	arpack? ( sci-libs/arpack )
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

FORTRAN="g77 gfortran ifc"

src_prepare() {
	python_version

	epatch "${FILESDIR}"/${PN}-1.2.0-install-fix.patch
	epatch "${FILESDIR}"/${PN}-1.2.0-contrib.patch
	epatch "${FILESDIR}"/${PN}-1.2.0-link.patch
	epatch "${FILESDIR}"/${P}-autoconf-2.64.patch
	sed "s:GENTOO_PKG_NAME:${PN}:g" \
	-i Makefile.am || die "Cannot correct package name"
	eautoreconf
}

src_configure() {
	local myconf="--docdir=/usr/share/doc/${PF}"
	use blas && myconf="${myconf} --with-blas=-lblas"
	use arpack && myconf="${myconf} --with-arpack=/usr/$(get_libdir)"

	# check which mpi version is installed and tell configure
	if use mpi; then
		export CC="/usr/bin/mpicc"
		export F77="/usr/bin/mpif77"

		if has_version sys-cluster/mpich; then
	 		myconf="${myconf} --with-mpich=/usr"
		elif has_version sys-cluster/mpich2; then
			myconf="${myconf} --with-mpich2=/usr"
		elif has_version sys-cluster/lam-mpi; then
			myconf="${myconf} --with-lam=/usr"
		elif has_version sys-cluster/openmpi; then
			myconf="${myconf} --with-openmpi=/usr"
		fi
	fi || die "Failed to select proper mpi implementation"

	# apbs' configure's openmp detection is broken; we'll
	# work around this until it is fixed
	if use openmp; then
		append-flags -fopenmp
	else
		myconf="${myconf} --disable-openmp"
	fi

	econf $(use_enable python) \
		--disable-maloc-rebuild \
		${myconf} || die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_test() {
	cd examples && make test \
		|| die "Tests failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install \
		|| die "make install failed"

	dodoc AUTHORS INSTALL README NEWS ChangeLog \
		|| die "Failed to install docs"

	if use doc; then
		dohtml -r doc/* || die "Failed to install html docs"
	fi
}
