# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.2.5.ebuild,v 1.1 2010/04/17 17:14:03 nerdboy Exp $

EAPI=2
inherit autotools eutils flag-o-matic

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://geotiff.osgeo.org/"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc python"

RDEPEND=">=media-libs/tiff-3.9.1
	media-libs/jpeg
	sci-libs/proj"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.4-soname.patch
	epatch "${FILESDIR}"/${P}-make.patch
	epatch "${FILESDIR}"/${P}-listgeo-link-hack.patch
	filter-ldflags -Wl,-O1
	eautoconf
	eautomake
}

src_compile() {
	emake -j1 || die "emake failed"

	if use doc; then
	    emake dox || die "emake dox failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dobin bin/makegeo || die "dobin makegeo failed"

	if use python; then
		dobin csv/*.py || die "dobin python failed"
	fi

	dodoc README
	newdoc csv/README README.csv
	use doc && dohtml docs/api/*
}
