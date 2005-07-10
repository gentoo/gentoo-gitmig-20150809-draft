# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.2.1-r1.ebuild,v 1.2 2005/07/10 20:33:19 nerdboy Exp $

inherit eutils flag-o-matic

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~hppa ~mips ~alpha ~amd64 ~ppc ~ppc64"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/tiff-3.7.0
	sci-libs/proj"

src_compile() {
	append-flags -fPIC
	econf || die
	emake -j1 || die
}

src_install() {
	dobin bin/{listgeo,geotifcp,makegeo} || die
	insinto usr/include
	dolib.a libgeotiff.a
	dolib.so libgeotiff.so.${PV}
	dosym libgeotiff.so.${PV} usr/lib/libgeotiff.so
	doins libxtiff/*.h
	doins *.h
	doins *.inc
	insinto usr/share/epsg_csv
	doins csv/*.csv
}
