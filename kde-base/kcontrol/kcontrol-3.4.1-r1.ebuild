# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.4.1-r1.ebuild,v 1.4 2005/06/30 21:02:21 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Control Center"
KEYWORDS="x86 amd64 ~ppc64 ~ppc ~sparc"
IUSE="ssl arts ieee1394 logitech-mouse opengl"

PATCHES="$FILESDIR/configure.in.in-kdm-settings.diff
	$FILESDIR/kdebase-3.4.1-configure.patch"

DEPEND="ssl? ( dev-libs/openssl )
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )"

RDEPEND="${DEPEND}
$(deprange $PV $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)
$(deprange $PV $MAXKDEVER kde-base/kdesu)
$(deprange $PV $MAXKDEVER kde-base/khelpcenter)"

KMEXTRACTONLY="kicker/core/kicker.h
	    kwin/kwinbindings.cpp
	    kicker/core/kickerbindings.cpp
	    kicker/taskbar/taskbarbindings.cpp
	    kdesktop/kdesktopbindings.cpp
	    klipper/klipperbindings.cpp
	    kxkb/kxkbbindings.cpp
	    libkonq/
	    kioslave/thumbnail/configure.in.in" # for the HAVE_LIBART test

KMCOMPILEONLY="kicker/share" # for kickerSettings.h
KMEXTRA="doc/kinfocenter"

src_compile() {
	myconf="$myconf `use_with ssl` `use_with arts` `use_with opengl gl`
	        `use_with ieee1394 libraw1394` `use_with logitech-mouse libusb`"
	kde-meta_src_compile
}
