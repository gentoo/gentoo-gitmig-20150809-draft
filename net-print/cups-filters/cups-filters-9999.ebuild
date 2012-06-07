# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-filters/cups-filters-9999.ebuild,v 1.1 2012/06/07 21:37:12 dilfridge Exp $

EAPI=4

DESCRIPTION="Cups PDF filters"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/openprinting/pdfasstandardprintjobformat"

if [[ "${PV}"=="9999" ]] ; then 
	inherit base autotools bzr
	EBZR_REPO_URI="http://bzr.linuxfoundation.org/openprinting/cups-filters"
	KEYWORDS=""
else
	SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.gz"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg lcms png tiff"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/poppler[jpeg?,lcms?]
	media-libs/fontconfig
	media-libs/freetype:2
	>net-print/cups-1.5.9999
	sys-libs/zlib
	jpeg? ( virtual/jpeg )
	lcms? ( media-libs/lcms:2 )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-beta.patch"
	"${FILESDIR}/${P}-warnings.patch"
	"${FILESDIR}/${P}-lib.patch"
)

src_prepare() {
	base_src_prepare
	if [[ "${PV}"=="9999" ]] ; then
		eautoreconf
	fi
}

src_configure() {
	econf \
		--with-fontdir=fonts/conf.d \
		--enable-imagefilters \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with lcms cms) \
		--without-php
}
