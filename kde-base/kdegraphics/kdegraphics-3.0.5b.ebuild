# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.0.5b.ebuild,v 1.4 2003/09/06 23:54:21 msterret Exp $
inherit kde-dist

IUSE="scanner gphoto2 tetex"
DESCRIPTION="KDE $PV - graphics-related apps"

KEYWORDS="x86 ppc ~alpha sparc"

newdepend "gphoto2? ( >=media-gfx/gphoto2-2.0_beta1 )
	dev-lang/perl
	scanner? ( media-gfx/sane-backends  )
	tetex? ( >=app-text/tetex-1.0.7 )
	media-libs/imlib
	app-text/ghostscript"
#	x86? ( scanner? sys-libs/libieee1284 )

use gphoto2	&& myconf="$myconf --with-kamera --with-gphoto2-includes=/usr/include/gphoto2 \
				   --with-gphoto2-libraries=/usr/lib/gphoto2 \
				   --with-gpio --with-gpio-includes=/usr/include \
				   --with-gpio-libraries=/usr/lib" || myconf="$myconf --without-kamera"

use tetex 	&& myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"

use scanner	|| KDE_REMOVE_DIR="kooka libkscan"

myconf="$myconf --with-imlib --with-imlib-config=/usr/bin "

need-autoconf 2.1

src_unpack() {

	kde_src_unpack

	if [ -z "`use scanner`" ]; then
	cd $S
	mv Makefile.am Makefile.am.orig
	sed -e 's:$(KSCANDIR)::' Makefile.am.orig > Makefile.am
	fi
}

src_install() {
	kde_src_install

	# default kghostviewrc beacuse kghostview doesn't generate a working default run on its 1st run
	# fix bug #6562
	dodir $PREFIX/share/config
	cp $FILESDIR/$P-kghostviewrc $D/$PREFIX/share/config/kghostviewrc
}
