# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.4.0.ebuild,v 1.4 2005/03/25 07:56:22 greg_g Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Control Center"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="ssl arts ieee1394 logitech-mouse opengl"
PATCHES="$FILESDIR/configure.in.in-kdm-settings.diff"

DEPEND="ssl? ( dev-libs/openssl )
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )"

RDEPEND="${DEPEND}
$(deprange $PV $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)"

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

src_compile() {
	myconf="$myconf `use_with ssl` `use_with arts` `use_with opengl gl`"
	kde-meta_src_compile
}
