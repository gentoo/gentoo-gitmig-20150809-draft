# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.2.0_beta1.ebuild,v 1.6 2003/11/13 20:47:08 caleb Exp $
inherit kde-dist

IUSE="gphoto2 tetex scanner"
DESCRIPTION="KDE graphics-related apps"

KEYWORDS="~x86"

newdepend "gphoto2? ( media-gfx/gphoto2 media-libs/libgpio )
	dev-lang/perl
	scanner? ( media-gfx/sane-backends )
	tetex? ( virtual/tetex )
	bidi? ( dev-libs/fribidi )
	media-libs/imlib
	app-text/ghostscript
	virtual/glut virtual/opengl
	media-libs/tiff
	x86? ( scanner? sys-libs/libieee1284 )"

RDEPEND="$RDEPEND app-text/xpdf"

use gphoto2	&& myconf="$myconf --with-kamera --with-gphoto2-includes=/usr/include/gphoto2 \
				   --with-gphoto2-libraries=/usr/lib/gphoto2 \
				   --with-gpio --with-gpio-includes=/usr/include \
				   --with-gpio-libraries=/usr/lib" || myconf="$myconf --without-kamera"

use tetex 	&& myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"

use scanner	|| DO_NOT_COMPILE="kooka libkscan"

myconf="$myconf --with-imlib --with-imlib-config=/usr/bin"

