# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.0.3.ebuild,v 1.2 2002/09/20 10:21:13 danarmak Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - graphics-related apps"

KEYWORDS="x86 ppc"

newdepend "gphoto2? ( >=media-gfx/gphoto2-2.0_beta1 >=media-libs/libgpio-20010607 )
	    sys-devel/perl
	    scanner? ( media-gfx/sane-backends )
	    tetex? ( >=app-text/tetex-1.0.7 )
	    media-libs/imlib
	    app-text/ghostscript"

use gphoto2	&& myconf="$myconf --with-kamera --with-gphoto2-includes=/usr/include/gphoto2 \
				   --with-gphoto2-libraries=/usr/lib/gphoto2 \
				   --with-gpio --with-gpio-includes=/usr/include \
				   --with-gpio-libraries=/usr/lib" || myconf="$myconf --without-kamera"

use tetex 	&& myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"

use scanner	|| KDE_REMOVE_DIR="kooka libkscan"

myconf="$myconf --with-imlib --with-imlib-config=/usr/bin "

src_unpack() {

    base_src_unpack
    
    if [ -z "`use scanner`" ]; then
	cd $S
	mv Makefile.am Makefile.am.orig
	sed -e 's:$(KSCANDIR)::' Makefile.am.orig > Makefile.am
    fi

}