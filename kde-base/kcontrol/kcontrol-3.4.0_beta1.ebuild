# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.4.0_beta1.ebuild,v 1.4 2005/02/02 18:14:19 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Control Center"
KEYWORDS="~x86"
IUSE="ssl arts ieee1394 opengl"
PATCHES="$FILESDIR/configure.in.in-kdm-settings.diff"

DEPEND="ssl? ( dev-libs/openssl )
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	dev-libs/libusb" # to support some logitech mice - should get a local useflag
			 # (this isn't a separate kcm but a part of the input module)
RDEPEND="${DEPEND}
$(deprange-dual $PV $MAXKDEVER kde-base/kcminit)
$(deprange-dual $PV $MAXKDEVER kde-base/kdebase-applnk)"

KMEXTRACTONLY="kicker/core/kicker.h
	    kwin/kwinbindings.cpp
	    kicker/core/kickerbindings.cpp
	    kicker/taskbar/taskbarbindings.cpp
	    kdesktop/kdesktopbindings.cpp
	    klipper/klipperbindings.cpp
	    kxkb/kxkbbindings.cpp
	    libkonq/
	    kioslave/thumbnail/configure.in.in" # for the HAVE_LIBART test

src_compile() {
	myconf="$myconf `use_with ssl` `use_with arts` `use_with opengl gl`"
	kde-meta_src_compile
}
