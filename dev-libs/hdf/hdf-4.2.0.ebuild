# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hdf/hdf-4.2.0.ebuild,v 1.1 2003/12/17 08:10:54 phosphan Exp $

# substitute second dot by "r"
MY_PV=${PV/./X}
TMP_PV=${MY_PV/./r}
MY_PV=${TMP_PV/X/.}

S="${WORKDIR}/${PN}${MY_PV}"

DESCRIPTION="HDF4 is a general purpose library and file format for storing scientific data."
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/pub/outgoing/hdf4/hdf${MY_PV}/hdf${MY_PV}.tar.gz"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/hdf4.html"

LICENSE="NCSA-HDF"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib
		media-libs/jpeg
		dev-libs/szip
		app-sci/netcdf
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	# collides with netCDF
	sed -i 's/\(^SUBDIR.*\)mfhdf\(.*\)/\1\2/' Makefile.in
}

src_compile() {
	local myconf="--enable-production --with-szlib=/usr"
	econf ${myconf} || die "configure failed"
	make || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README release_notes/*.txt
}
