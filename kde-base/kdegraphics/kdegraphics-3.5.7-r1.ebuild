# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.5.7-r1.ebuild,v 1.8 2007/08/11 14:48:33 armin76 Exp $

inherit kde-dist eutils

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
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
	pdf? ( >=app-text/poppler-0.5.1
		>=app-text/poppler-bindings-0.5.1 )"

RDEPEND="${DEPEND}
	tetex? (
	|| ( >=app-text/tetex-2
		 app-text/ptex
		 app-text/cstetex
		 app-text/dvipdfm ) )"

PATCHES="${FILESDIR}/post-3.5.7-kdegraphics-CVE-2007-3387.diff"

pkg_setup() {
	kde_pkg_setup
	for ghostscript in app-text/ghostscript-{gnu,esp,afpl}; do
		if has_version ${ghostscript} && ! built_with_use ${ghostscript} X; then
			eerror "This package requires ${ghostscript} compiled with X11 support."
			eerror "Please reemerge ${ghostscript} with USE=\"X\"."
			die "Please reemerge ${ghostscript} with USE=\"X\"."
		fi
	done
	if use pdf && ! built_with_use app-text/poppler-bindings qt3; then
		eerror "This package requires app-text/poppler-bindings compiled with Qt 3.x support."
		eerror "Please reemerge app-text/poppler-bindings with USE=\"qt3\"."
		die "Please reemerge app-text/poppler-bindings with USE=\"qt3\"."
	fi
}

src_compile() {
	local myconf="$(use_with openexr) $(use_with pdf poppler)
				  $(use_with gphoto2 kamera)"

	use imlib || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kuickshow"
	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"
	use povray || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpovmodeler"
	use pdf || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpdf"

	rm -f "${S}/configure" # ask rebuilding
	kde_src_compile
}
