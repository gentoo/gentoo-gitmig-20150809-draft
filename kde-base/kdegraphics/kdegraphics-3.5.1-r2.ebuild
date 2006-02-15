# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.5.1-r2.ebuild,v 1.5 2006/02/15 22:23:37 corsair Exp $

inherit kde-dist eutils

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gphoto2 imlib openexr opengl pdf povray scanner tetex"

DEPEND="~kde-base/kdebase-${PV}
	>=media-libs/freetype-2
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
	pdf? ( >=app-text/poppler-0.5.0-r1
		>=app-text/poppler-bindings-0.5.0 )"

RDEPEND="${DEPEND}
	tetex? (
	|| ( >=app-text/tetex-2
	     app-text/ptex
	     app-text/cstetex
	     app-text/dvipdfm ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

SRC_URI="${SRC_URI}
	mirror://gentoo/kpdf-${PV}-poppler-2.patch.bz2"

PATCHES="${FILESDIR}/kpdf-3.5.1-saveas.patch
	${DISTDIR}/kpdf-${PV}-poppler-2.patch.bz2"

pkg_setup() {
	if ! built_with_use virtual/ghostscript X; then
		eerror "This package requires virtual/ghostscript compiled with X11 support."
		eerror "Please reemerge virtual/ghostscript with USE=\"X\"."
		die "Please reemerge virtual/ghostscript with USE=\"X\"."
	fi
	if use pdf && ! built_with_use app-text/poppler-bindings qt; then
		eerror "This package requires app-text/poppler-bindings  compiled with Qt support."
		eerror "Please reemerge app-text/poppler-bindings with USE=\"qt\"."
		die "Please reemerge app-text/poppler-bindings with USE=\"qt\"."
	fi
}

src_compile() {
	local myconf="$(use_with openexr) $(use_with pdf poppler)
	              $(use_with gphoto2 kamera)"

	use imlib || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kuickshow"
	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"
	use povray || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpovmodeler"
	use pdf || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpdf"

	replace-flags "-Os" "-O2" # see bug 114822

	rm -f ${S}/configure # ask rebuilding
	kde_src_compile
}
