# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-2.2.1-r1.ebuild,v 1.1 2001/09/29 12:42:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="${DESCRIPTION}Graphics"

DEPEND="$DEPEND sys-devel/perl
	tex? ( >=app-text/tetex-1.0.7 )
        gphoto2? ( >=media-gfx/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )"

RDEPEND="$RDEPEND gphoto2? ( >=media-gfx/gphoto-2.0_beta1 >=media-libs/libgpio-20010607 )"

src_compile() {

	kde-base_src_compile myconf

	use gphoto2 && myconf="$myconf --with-gphoto2-includes=/usr/include/gphoto2 --with-gphoto2-libraries=/usr/lib/gphoto2" || myconf="$myconf --without-kamera"

	kde-base_src_compile configure make

}


