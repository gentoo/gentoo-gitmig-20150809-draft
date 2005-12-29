# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.5.0-r4.ebuild,v 1.2 2005/12/29 10:38:24 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gphoto2 imlib openexr opengl pdflib povray scanner tetex"

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
	pdflib? ( >=app-text/poppler-0.3.1 )"

RDEPEND="${DEPEND}
	tetex? (
	|| ( >=app-text/tetex-2
	     app-text/ptex
	     app-text/cstetex
	     app-text/dvipdfm ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

# tiff is mandatory for kfile-plugins/tiff and kooka, the check comes
# from acinclude.m4.in and there's no switch. There is a --with-tiff
# check coming from kviewshell/plugins/djvu/libdjvu/configure.in.in,
# but it has no effect.

PATCHES="${FILESDIR}/post-3.5.0-kdegraphics-CAN-2005-3193.diff
	${FILESDIR}/kpdf-3.5.0-splitter-io.patch
	${FILESDIR}/kpdf-3.5.0-cropbox-fix.patch
	${FILESDIR}/kdegraphics-3.5.0-kpovmodeler.patch"

pkg_setup() {
	if ! built_with_use virtual/ghostscript X; then
		eerror "This package requires virtual/ghostscript compiled with X11 support."
		eerror "Please reemerge virtual/ghostscript with USE=\"X\"."
		die "Please reemerge virtual/ghostscript with USE=\"X\"."
	fi
	if use pdflib && ! built_with_use app-text/poppler qt; then
		eerror "This package requires app-text/poppler compiled with Qt support."
		eerror "Please reemerge app-text/poppler with USE=\"qt\"."
		die "Please reemerge app-text/poppler with USE=\"qt\"."
	fi
}

src_compile() {
	local myconf="$(use_with openexr) $(use_with pdflib poppler)
	              $(use_with gphoto2 kamera)"

	use imlib || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kuickshow"
	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"
	use povray || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpovmodeler"

	kde_src_compile
}
