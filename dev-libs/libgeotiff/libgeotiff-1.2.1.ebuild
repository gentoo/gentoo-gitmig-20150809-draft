# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgeotiff/libgeotiff-1.2.1.ebuild,v 1.5 2003/11/24 18:00:48 rphillips Exp $

inherit base eutils

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	>=media-libs/tiff-3.6.0
	dev-libs/proj"

src_unpack() {
	base_src_unpack

	#cd ${S}
	#patch -p0 -s < ${FILESDIR}/geo_trans.diff
}

src_compile() {
	econf || die
	MAKEOPTS="-j1" pmake || die
}

src_install() {
	into /usr
	exeinto /usr/bin
	doexe bin/listgeo
	doexe bin/geotifcp
	doexe bin/makegeo
	insinto usr/include
	dolib.a libgeotiff.a
	dolib.so libgeotiff.so.${PV}
	dosym libgeotiff.so.${PV} usr/lib/libgeotiff.so
	doins xtiffio.h xtiffiop.h geotiff.h geotiffio.h geovalues.h geonames.h geokeys.h geo_tiffp.h geo_config.h geo_keyp.h geo_normalize.h cpl_serv.h cpl_csv.h epsg_datum.inc epsg_gcs.inc epsg_pm.inc epsg_units.inc geo_ctrans.inc epsg_ellipse.inc epsg_pcs.inc epsg_proj.inc epsg_vertcs.inc geokeys.inc
	mkdir -p ${D}/usr/share/epsg_csv
	insinto usr/share/epsg_csv
	doins csv/*.csv
}
