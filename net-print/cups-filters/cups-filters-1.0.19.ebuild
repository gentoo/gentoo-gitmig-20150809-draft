# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-filters/cups-filters-1.0.19.ebuild,v 1.2 2012/07/18 22:34:24 dilfridge Exp $

EAPI=4

GENTOO_DEPEND_ON_PERL=no

inherit base perl-module

if [[ "${PV}" == "9999" ]] ; then
	inherit autotools bzr
	EBZR_REPO_URI="http://bzr.linuxfoundation.org/openprinting/cups-filters"
	KEYWORDS=""
else
	inherit autotools
	SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.xz"
	KEYWORDS=""
fi
DESCRIPTION="Cups PDF filters"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/openprinting/pdfasstandardprintjobformat"

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg perl png static-libs tiff"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/poppler[jpeg?,lcms,tiff?]
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	>net-print/cups-1.5.9999
	sys-libs/zlib
	jpeg? ( virtual/jpeg )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-poppler020.patch" )

src_prepare() {
	base_src_prepare
	eautoreconf
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

src_compile() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_prep
		perl-module_src_compile
		popd > /dev/null
	fi
}

src_install() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_install
		fixlocalpod
		popd > /dev/null
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}
