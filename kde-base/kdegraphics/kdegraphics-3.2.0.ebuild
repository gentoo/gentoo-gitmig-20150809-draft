# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.2.0.ebuild,v 1.7 2004/02/19 14:46:28 vapier Exp $

inherit kde-dist

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="x86 ppc sparc hppa ~amd64"
IUSE="gphoto2 tetex scanner opengl"

DEPEND="~kde-base/kdebase-${PV}
	gphoto2? ( media-gfx/gphoto2 )
	scanner? ( media-gfx/sane-backends )
	tetex? ( virtual/tetex )
	dev-libs/fribidi
	opengl? ( virtual/glut virtual/opengl )
	media-libs/imlib
	virtual/ghostscript
	media-libs/tiff
	x86? ( scanner? sys-libs/libieee1284 )"
RDEPEND="${DEPEND}
	app-text/xpdf"

src_compile() {
	use gphoto2	\
		&& myconf="$myconf --with-kamera \
				   --with-gphoto2-includes=/usr/include/gphoto2 \
				   --with-gphoto2-libraries=/usr/lib/gphoto2" \
		|| myconf="$myconf --without-kamera"

	use tetex 	&& myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"

	use scanner	|| DO_NOT_COMPILE="$DO_NOT_COMPILE kooka libkscan"

	myconf="$myconf --with-imlib --with-imlib-config=/usr/bin"
	kde_src_compile
}
