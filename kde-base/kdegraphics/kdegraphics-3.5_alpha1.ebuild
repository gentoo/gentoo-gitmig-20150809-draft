# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.5_alpha1.ebuild,v 1.1 2005/08/24 23:25:40 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
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

src_compile() {
	local myconf="$(use_with openexr) $(use_with pdflib poppler)
	              $(use_with gphoto2 kamera)"

	use imlib || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kuickshow"

	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"
	use povray || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kpovmodeler"

	kde_src_compile
}
