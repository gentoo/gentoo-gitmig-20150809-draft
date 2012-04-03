# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-filters/cups-filters-1.0.11.ebuild,v 1.1 2012/04/03 16:02:59 scarabeus Exp $

EAPI=4

inherit autotools

DESCRIPTION="Cups PDF filters"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/openprinting/pdfasstandardprintjobformat"
SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jpeg lcms png tiff zlib"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/poppler[jpeg?,lcms?]
	media-libs/freetype:2
	net-print/cups
	jpeg? ( virtual/jpeg )
	lcms? ( media-libs/lcms:2 )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.11-makefiles.patch
	eautoreconf
}

src_configure() {
	econf \
		--without-php \
		--with-optim="${CFLAGS}" \
		$(use_enable jpeg) \
		$(use_enable jpeg libjpeg) \
		$(use_enable lcms cms) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_enable zlib)
}
