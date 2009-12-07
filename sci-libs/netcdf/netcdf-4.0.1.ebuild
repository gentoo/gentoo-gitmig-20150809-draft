# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-4.0.1.ebuild,v 1.1 2009/12/07 08:59:30 bicatali Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"
HOMEPAGE="http://www.unidata.ucar.edu/software/netcdf/"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE="doc fortran hdf5 mpi szip"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="hdf5? ( >=sci-libs/hdf5-1.8[zlib,szip?,mpi?] )"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2
	doc? ( virtual/latex-base )
	fortran? ( dev-lang/cfortran )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
	rm -f fortran/cfortran.h || die
	eautoreconf
}

src_configure() {
	local myconf
	if use hdf5; then
		myconf="--with-hdf5=/usr --with-zlib=/usr"
		use szip && myconf="${myconf} --with-szlib=/usr"
	fi

	econf \
		--docdir=/usr/share/doc/${PF} \
		--enable-shared \
		$(use_enable fortran f77) \
		$(use_enable fortran f90) \
		$(use_enable fortran separate-fortran) \
		$(use_enable hdf5 netcdf-4) \
		$(use_enable hdf5 ncgen4) \
		$(use_enable doc docs-install) \
		${myconf}
}

src_compile() {
	# hack to allow parallel build
	if use doc; then
		emake pdf || die "emake pdf failed"
		cd man4
		emake -j1 || die "emake doc failed"
		cd ..
	fi
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README RELEASE_NOTES VERSION
}
