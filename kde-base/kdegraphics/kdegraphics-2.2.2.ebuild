# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-2.2.2.ebuild,v 1.7 2002/07/25 17:53:21 danarmak Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - graphics-related apps"

KEYWORDS="x86"

DEPEND="$DEPEND sys-devel/perl
	media-gfx/sane-backends
	tetex? ( >=app-text/tetex-1.0.7 )"


newdepend "gphoto2? ( >=media-gfx/gphoto2-2.0_beta1 >=media-libs/libgpio-20010607 )"


src_compile() {

	kde_src_compile myconf

	use gphoto2 && myconf="$myconf --with-gphoto2-includes=/usr/include/gphoto2 --with-gphoto2-libraries=/usr/lib/gphoto2" || myconf="$myconf --without-kamera"
	use tetex && myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"
	kde_src_compile configure make

}


