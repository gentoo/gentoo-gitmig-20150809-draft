# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okular/okular-4.0.2.ebuild,v 1.3 2008/05/13 07:52:54 pva Exp $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="Okular is an universal document viewer based on KPDF for KDE 4."
KEYWORDS="~amd64 ~x86"
IUSE="chm debug djvu htmlhandbook jpeg pdf tiff"

RDEPEND="
	>=app-text/libspectre-0.2
	media-libs/freetype
	kde-base/qimageblitz
	chm? ( dev-libs/chmlib )
	djvu? ( >=app-text/djvu-3.5.17 )
	jpeg? ( media-libs/jpeg )
	pdf? ( >=app-text/poppler-0.5.4
		>=app-text/poppler-bindings-0.5.4 )
	tiff? ( media-libs/tiff )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/${KMNAME}-${PV}-system-libspectre.patch"

pkg_setup() {
	if use pdf; then
		KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
			app-text/poppler-bindings qt4"
	fi
	kde4-meta_pkg_setup
}

src_compile() {
	# remove internal copy of libspectre
	rm -r "${S}"/okular/generators/spectre/libspectre || \
		die "Failed to remove internal copy of libspectre."

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with chm CHM)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff TIFF)"

	kde4-meta_src_compile
}
