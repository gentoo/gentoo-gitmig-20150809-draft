# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.4.0_beta1.ebuild,v 1.1 2005/01/14 00:19:31 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="~x86"
IUSE="gphoto2 imlib opengl povray scanner tetex"

DEPEND="~kde-base/kdebase-${PV}
	gphoto2? ( media-gfx/gphoto2 )
	scanner? ( media-gfx/sane-backends )
	dev-libs/fribidi
	imlib? ( media-libs/imlib )
	virtual/ghostscript
	media-libs/tiff
	povray? ( x86? ( media-gfx/povray
			virtual/opengl ) )
	!media-gfx/kolourpaint"

RDEPEND="${DEPEND}
	app-text/xpdf
	tetex? (
	|| ( >=app-text/tetex-2
	app-text/ptex
	app-text/cstetex
	app-text/dvipdfm )
	)"

src_compile() {
	use gphoto2	\
		&& myconf="$myconf --with-kamera \
				   --with-gphoto2-includes=/usr/include/gphoto2 \
				   --with-gphoto2-libraries=/usr/lib/gphoto2" \
		|| myconf="$myconf --without-kamera"

	use scanner	|| export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"

	use imlib \
		&& myconf="$myconf --with-imlib --with-imlib-config=/usr/bin" \
		|| myconf="$myconf --without-imlib"

	kde_src_compile
}
