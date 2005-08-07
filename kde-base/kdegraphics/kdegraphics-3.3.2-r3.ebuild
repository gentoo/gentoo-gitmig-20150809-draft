# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.3.2-r3.ebuild,v 1.3 2005/08/07 14:17:22 kloeri Exp $

inherit kde-dist eutils

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE="gphoto2 imlib jpeg2k opengl povray scanner tetex"

DEPEND="~kde-base/kdebase-${PV}
	gphoto2? ( media-libs/libgphoto2 )
	scanner? ( media-gfx/sane-backends )
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi
	opengl? ( virtual/glut virtual/opengl )
	imlib? ( media-libs/imlib )
	virtual/ghostscript
	media-libs/tiff
	x86? ( scanner? ( sys-libs/libieee1284 ) )
	povray? ( x86? ( media-gfx/povray ) )
	jpeg2k? ( x86? ( media-libs/jasper ) )"

RDEPEND="${DEPEND}
	app-text/xpdf
	tetex? (
	|| ( >=app-text/tetex-2
	app-text/ptex
	app-text/cstetex
	app-text/dvipdfm )
	)"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/post-3.3.2-kdegraphics.diff
	epatch ${FILESDIR}/CAN-2005-0064.patch
	epatch ${FILESDIR}/post-3.3.1-kdegraphics-4.diff
}

src_compile() {
	use gphoto2	\
		&& myconf="$myconf --with-kamera \
				   --with-gphoto2-includes=/usr/include/gphoto2 \
				   --with-gphoto2-libraries=/usr/lib/gphoto2" \
		|| myconf="$myconf --without-kamera"

	use tetex 	&& myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"

	use scanner	|| DO_NOT_COMPILE="$DO_NOT_COMPILE kooka libkscan"

	use imlib \
		&& myconf="$myconf --with-imlib --with-imlib-config=/usr/bin" \
		|| myconf="$myconf --without-imlib"

	kde_src_compile
}
