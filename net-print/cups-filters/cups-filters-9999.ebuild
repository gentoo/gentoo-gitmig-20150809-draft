# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-filters/cups-filters-9999.ebuild,v 1.7 2012/06/08 22:33:42 dilfridge Exp $

EAPI=4

inherit base

if [[ "${PV}"=="9999" ]] ; then
	inherit autotools bzr
	EBZR_REPO_URI="http://bzr.linuxfoundation.org/openprinting/cups-filters"
	KEYWORDS=""
else
	SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.gz"
	KEYWORDS=""
fi
DESCRIPTION="Cups PDF filters"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/openprinting/pdfasstandardprintjobformat"

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg png static-libs tiff"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/poppler[jpeg?,lcms,tiff?]
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	>net-print/cups-1.5.9999
	sys-libs/zlib
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-png.patch"
	"${FILESDIR}/${P}-imagetopdf.patch"
	"${FILESDIR}/${P}-imagetoraster.patch"
)


src_prepare() {
	base_src_prepare
	if [[ "${PV}"=="9999" ]] ; then
		eautoreconf
	fi
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--with-fontdir="fonts/conf.avail" \
		--enable-imagefilters \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with tiff) \
		--without-php
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
