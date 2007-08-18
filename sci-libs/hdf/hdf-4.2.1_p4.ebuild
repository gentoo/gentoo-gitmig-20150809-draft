# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf/hdf-4.2.1_p4.ebuild,v 1.1 2007/08/18 12:07:07 bicatali Exp $

inherit versionator autotools flag-o-matic fortran

MY_PN="${PN/hdf/HDF}"
#4.2.1_p4 -> 4.2r1-hrepack-p4
MY_PV=$(printf '%d.%dr%d-hrepack-%s' $(get_version_components))

DESCRIPTION="HDF4 is a general purpose library and file format for storing scientific data."

#SRC_URI="ftp://ftp.hdfgroup.org/HDF/HDF_Current/src/${MY_PN}${MY_PV}.tar.gz"
#S="${WORKDIR}/${MY_PN}${MY_PV}"
SRC_URI="ftp://ftp.hdfgroup.org/HDF/HDF_Current/src/patches/${MY_PV}.tar.gz"
S="${WORKDIR}/${MY_PV}"

HOMEPAGE="http://www.hdfgroup.org/hdf4.html"

LICENSE="NCSA-HDF"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="szip test"

RDEPEND="sys-libs/zlib
	media-libs/jpeg
	szip? ( >=sci-libs/szip-2.0 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	test? ( sci-libs/netcdf )"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# We need shared libraries, see BUG #75415.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/01/24
	epatch "${FILESDIR}"/${P}-shared-libs.patch

	epatch "${FILESDIR}"/${P}-maxavailfiles.patch

	if use test; then
		sed -i \
			-e 's/$(LIBS)/$(LIBS) -lnetcdf/g' \
			mfhdf/ncgen/Makefile.am || die "sed for test failed"
	fi

	# sed for a test: might be gone in future gfortran version
	sed -i \
		-e 's|"||g' \
		hdf/test/fortestF.f || die "failed fixing fortestF.f"

	eautoreconf
}

src_compile() {
	# BUG #75415, the shipped config/linux-gnu settings are broken.
	# -Wsign-compare does not work with g77, causing lack of -fPIC for shared
	# objects.
	sed -i \
		-e 's|-O3 -fomit-frame-pointer||g' \
		-e 's|-Wsign-compare||g' \
		"${S}"/config/linux-gnu || die "sed failed"

	use ppc && append-flags -DSUN
	append-flags -DHAVE_NETCDF

	econf \
		--enable-production \
		$(use_with szip) \
		F77="${FORTRANC}" \
		|| die "econf failed"

	emake  || die "emake failed"
}

src_test() {
	emake -j1 check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README release_notes/*.txt || die "dodoc failed"

	cd "${D}"
	einfo "Renaming included versions of ncdump and ncgen to hdfdump and hdfgen, respectively."
	mv -v usr/bin/ncgen usr/bin/hdfgen || die
	mv -v usr/bin/ncdump usr/bin/hdfdump || die
	mv -v usr/share/man/man1/ncgen.1 usr/share/man/man1/hdfgen.1 || die
	mv -v usr/share/man/man1/ncdump.1 usr/share/man/man1/hdfdump.1 || die
	if has_version sci-libs/netcdf; then
		einfo '"sci-libs/netcdf" is already installed - not installing netcdf related header files.'
		rm -v usr/include/netcdf.inc || die
		rm -v usr/include/netcdf.h || die
	fi
}
