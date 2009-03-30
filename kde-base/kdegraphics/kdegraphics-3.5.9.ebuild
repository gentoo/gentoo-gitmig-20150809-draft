# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.5.9.ebuild,v 1.10 2009/03/30 13:03:21 loki_val Exp $

EAPI="1"
inherit kde-dist eutils

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="gphoto2 imlib openexr opengl pdf povray scanner kpathsea"

DEPEND="~kde-base/kdebase-${PV}
	>=media-libs/freetype-2.3
	media-libs/fontconfig
	gphoto2? ( media-libs/libgphoto2 )
	scanner? ( media-gfx/sane-backends )
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi
	imlib? ( media-libs/imlib )
	virtual/ghostscript
	media-libs/tiff
	openexr? ( >=media-libs/openexr-1.2 )
	povray? ( media-gfx/povray
				virtual/opengl )
	pdf? ( >=virtual/poppler-qt3-0.6.1 )
	"

RDEPEND="${DEPEND}
	kpathsea? ( virtual/tex-base )"

pkg_setup() {
	kde_pkg_setup
	for ghostscript in app-text/ghostscript-{gnu,esp,afpl}; do
		if has_version ${ghostscript} && ! built_with_use ${ghostscript} X; then
			eerror "This package requires ${ghostscript} compiled with X11 support."
			eerror "Please reemerge ${ghostscript} with USE=\"X\"."
			die "Please reemerge ${ghostscript} with USE=\"X\"."
		fi
	done
}

src_compile() {
	local myconf="$(use_with openexr) $(use_with pdf poppler)
					$(use_with gphoto2 kamera)"

	DO_NOT_COMPILE="kmrml"
	use imlib || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kuickshow"
	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"
	use povray || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpovmodeler"
	use pdf || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpdf"

	# Fix the desktop file.
	sed -i -e "s:PDFViewer;:Viewer;:" "${S}/kpdf/shell/kpdf.desktop" || die "sed failed"

	rm -f "${S}/configure" # ask rebuilding
	kde_src_compile
}
