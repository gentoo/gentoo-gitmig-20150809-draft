# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf/hdf-4.2.6.ebuild,v 1.1 2011/12/22 17:36:28 bicatali Exp $

EAPI=4
inherit eutils fortran-2 toolchain-funcs autotools flag-o-matic

DESCRIPTION="General purpose library and format for storing scientific data"
HOMEPAGE="http://www.hdfgroup.org/hdf4.html"
SRC_URI="ftp://ftp.hdfgroup.org/HDF/HDF_Current/src/${P}.tar.bz2"

LICENSE="NCSA-HDF"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="fortran szip static-libs"

RDEPEND="virtual/jpeg
	sys-libs/zlib
	fortran? ( virtual/jpeg )
	szip? ( >=sci-libs/szip-2 )"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-autotools.patch
	eautoreconf
	[[ $(tc-getFC) = *gfortran ]] && append-fflags -fno-range-check
}

src_configure() {
	econf \
		--enable-shared \
		--enable-production=gentoo \
		--disable-netcdf \
		$(use_enable fortran) \
		$(use_enable static-libs static) \
		$(use_with szip szlib)
}

src_install() {
	default
	dodoc release_notes/{RELEASE,HISTORY,bugs_fixed,misc_docs}.txt
	cd "${ED}"usr
	mv bin/ncgen{,-hdf} || die
	mv bin/ncdump{,-hdf} || die
	mv share/man/man1/ncgen{,-hdf}.1 || die
	mv share/man/man1/ncdump{,-hdf}.1 || die
}
