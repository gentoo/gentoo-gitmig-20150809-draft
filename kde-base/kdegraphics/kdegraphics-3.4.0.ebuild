# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.4.0.ebuild,v 1.2 2005/03/18 17:25:34 morfic Exp $

inherit kde-dist

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="gphoto2 imlib nodrm opengl povray scanner tetex"

DEPEND="~kde-base/kdebase-${PV}
	gphoto2? ( media-gfx/gphoto2 )
	scanner? ( media-gfx/sane-backends )
	dev-libs/fribidi
	imlib? ( media-libs/imlib )
	virtual/ghostscript
	media-libs/tiff
	povray? ( media-gfx/povray
		  virtual/opengl )"

RDEPEND="${DEPEND}
	app-text/xpdf
	tetex? (
	|| ( >=app-text/tetex-2
	app-text/ptex
	app-text/cstetex
	app-text/dvipdfm )
	)"

src_compile() {
	if use gphoto2; then
		myconf="${myconf} --with-kamera \
				  --with-gphoto2-includes=/usr/include/gphoto2 \
				  --with-gphoto2-libraries=/usr/lib/gphoto2"
	else
		myconf="${myconf} --without-kamera"
	fi

	use scanner || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kooka libkscan"

	myconf="${myconf} $(use_with imlib) $(use_enable !nodrm kpdf-drm)"

	kde_src_compile
}
