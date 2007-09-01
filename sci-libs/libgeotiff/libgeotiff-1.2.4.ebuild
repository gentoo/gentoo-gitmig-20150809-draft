# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.2.4.ebuild,v 1.1 2007/09/01 19:59:10 nerdboy Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc python"

DEPEND="virtual/libc
	>=media-libs/tiff-3.7.0
	sci-libs/proj
	doc? ( app-doc/doxygen )"

WANT_AUTOCONF="latest"

src_compile() {
	epatch ${FILESDIR}/${P}-soname.patch || die "epatch failed"
	filter-ldflags "-Wl,-O1"
	eautoconf

	econf || die "econf failed"
	emake -j1 || die "emake failed"

	use doc && make dox || die "make dox failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	exeinto /usr/bin
	doexe bin/makegeo
	use python && doexe csv/*.py

	dodoc README
	newdoc csv/README README.csv
	use doc && dohtml docs/api/*
}
