# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/grib_api/grib_api-1.9.16.ebuild,v 1.1 2012/04/18 21:50:32 bicatali Exp $

EAPI=4
inherit eutils autotools

#MYP=${P}_libtool
MYP=${P}

DESCRIPTION="Library for decoding WMO FM-92 GRIB messages"
HOMEPAGE="http://www.ecmwf.int/products/data/software/grib_api.html"
SRC_URI="http://www.ecmwf.int/products/data/software/download/software_files/${MYP}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples fortran jpeg2k netcdf openmp png python static-libs"

DEPEND="jpeg2k? ( || ( media-libs/jasper media-libs/openjpeg ) )
	netcdf? ( sci-libs/netcdf )
	png? ( media-libs/libpng )
	python? ( dev-python/numpy )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.9.9-ieeefloat.patch \
		"${FILESDIR}"/${PN}-1.9.16-autotools.patch
	eautoreconf
}

src_configure() {
	local myconf
	if use jpeg2k; then
		myconf="--enable-jpeg"
		if hasv media-libs/jasper; then
			myconf="${myconf} --with-jasper=system --without-openjpeg"
		elif hasv media-libs/openjpeg; then
			myconf="${myconf} --without-jasper --with-openjpeg=system"
		fi
	else
		myconf="--disable-jpeg --without-jasper --without-openjpeg"
	fi

	# perl sources disappear from tar ball
	econf \
		--without-perl \
		$(use_enable fortran) \
		$(use_enable openmp omp-packing) \
		$(use_enable python) \
		$(use_enable python numpy) \
		$(use_enable static-libs static) \
		$(use_with netcdf netcdf "${EPREFIX}"/usr) \
		$(use_with png png-support) \
		${myconf}
}

src_install() {
	default
	use doc && dohtml html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		emake clean
		doins -r *
	fi
}
