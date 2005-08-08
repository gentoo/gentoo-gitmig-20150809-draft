# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.4.2.ebuild,v 1.4 2005/08/08 20:15:35 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Control Center"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl arts ieee1394 logitech-mouse opengl"

# configure.in.in-kdm-settings.diff: add configure tests from kdm necessary to configure kcontrol
# kdebase-3.4.1-configure.patch: add --with-libusb configure switch
PATCHES="$FILESDIR/configure.in.in-kdm-settings.diff
	$FILESDIR/kdebase-3.4.1-configure.patch"

DEPEND=">=media-libs/freetype-2
	media-libs/fontconfig
	ssl? ( dev-libs/openssl )
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )"

RDEPEND="${DEPEND}
$(deprange 3.4.1 $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)
$(deprange 3.4.1 $MAXKDEVER kde-base/kdesu)
$(deprange $PV $MAXKDEVER kde-base/khelpcenter)
$(deprange $PV $MAXKDEVER kde-base/khotkeys)"

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
