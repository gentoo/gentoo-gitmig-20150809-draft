# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeimage/freeimage-3.15.1.ebuild,v 1.1 2012/02/12 13:55:19 tupone Exp $

EAPI=3

inherit toolchain-funcs eutils

MY_PN=FreeImage
MY_PV=${PV//.}
MY_P=${MY_PN}${MY_PV}

DESCRIPTION="Image library supporting many formats"
HOMEPAGE="http://freeimage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	mirror://sourceforge/${PN}/${MY_P}.pdf
	mirror://gentoo/${P}-unbundling.patch.gz"

LICENSE="|| ( GPL-2 FIPL-1.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	media-libs/libpng
	media-libs/libmng
	virtual/jpeg
	media-libs/openjpeg
	media-libs/tiff
	media-libs/libraw
	media-libs/openexr"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${MY_PN}

src_prepare() {
	cd Source
	cp LibJPEG/{transupp.c,transupp.h,jinclude.h} . \
		|| die "Failed copying jpeg utility files"
	cp LibTIFF/{tiffiop,tif_dir}.h . \
		|| die "Failed copying private libtiff files"
	rm -rf LibPNG LibMNG LibOpenJPEG ZLib OpenEXR LibRawLite LibTIFF LibJPEG \
		|| die "Removing bundled libraries"
	edos2unix *.h *.c */*.cpp
	cd ..
	edos2unix Makefile.{gnu,fip}
	epatch "${WORKDIR}"/${P}-unbundling.patch
}

src_compile() {
	emake -f Makefile.gnu \
		CXX="$(tc-getCXX) -fPIC" \
		CC="$(tc-getCC) -fPIC" \
		${MY_PN} \
		|| die "emake gnu failed"
	emake -f Makefile.fip \
		CXX="$(tc-getCXX) -fPIC" \
		CC="$(tc-getCC) -fPIC" \
		${MY_PN} \
		|| die "emake fip failed"
}

src_install() {
	emake -f Makefile.gnu \
		install DESTDIR="${D}" INSTALLDIR="${D}"/usr/$(get_libdir) \
		|| die "emake install failed"
	emake -f Makefile.fip \
		install DESTDIR="${D}" INSTALLDIR="${D}"/usr/$(get_libdir) \
		|| die "emake install failed"
	dosym lib${PN}plus-${PV}.so /usr/$(get_libdir)/lib${PN}plus.so.3
	dosym lib${PN}plus.so.3 /usr/$(get_libdir)/lib${PN}plus.so

	dodoc Whatsnew.txt "${DISTDIR}"/${MY_P}.pdf
}
