# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgeotiff/libgeotiff-1.2.0.ebuild,v 1.1 2003/06/19 18:57:09 rphillips Exp $

inherit base eutils

DESCRIPTION="libgeotiff"
HOMEPAGE="http://remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
        >=media-libs/tiff-3.3.4
        >=dev-libs/proj-4.4.4"

src_unpack() {
	base_src_unpack

    cd ${S}
	patch -p0 -s < ${FILESDIR}/geo_trans.diff
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
	dolib.so libgeotiff.so.1.1.4
	dosym libgeotiff.so.1.1.4 usr/lib/libgeotiff.so
	doins xtiffio.h xtiffiop.h geotiff.h geotiffio.h geovalues.h geonames.h geokeys.h geo_tiffp.h geo_config.h geo_keyp.h geo_normalize.h cpl_serv.h cpl_csv.h epsg_datum.inc epsg_gcs.inc epsg_pm.inc epsg_units.inc geo_ctrans.inc epsg_ellipse.inc epsg_pcs.inc epsg_proj.inc epsg_vertcs.inc geokeys.inc
	mkdir -p ${D}/usr/share/epsg_csv
	insinto usr/share/epsg_csv
	doins csv/*.csv
}
