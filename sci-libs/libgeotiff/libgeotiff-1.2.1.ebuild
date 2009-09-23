# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.2.1.ebuild,v 1.7 2009/09/23 20:08:23 patrick Exp $

inherit eutils

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/tiff-3.7.0
	sci-libs/proj"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dobin bin/{listgeo,geotifcp,makegeo} || die "dobin failed"
	dolib.a libgeotiff.a
	dolib.so libgeotiff.so.${PV}
	dosym libgeotiff.so.${PV} usr/$(get_libdir)/libgeotiff.so || die "dosym failed"
	insinto usr/include
	doins libxtiff/*.h
	doins *.h
	doins *.inc
	insinto usr/share/epsg_csv
	doins csv/*.csv
}
