# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.2.0.ebuild,v 1.12 2005/01/06 22:40:09 sekretarz Exp $

inherit kde-dist

DESCRIPTION="KDE graphics-related apps"

KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
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
	# Disable kpdf because it's both deprecated AND it doesn't compile cleanly
	# using parallel make.  If you really want it, comment out the line below.
	DO_NOT_COMPILE="$DO_NOT_COMPILE kpdf"

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
