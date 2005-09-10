# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.5_alpha1.ebuild,v 1.2 2005/09/10 16:00:12 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The KDE Control Center"
KEYWORDS="~amd64"
IUSE="ssl arts ieee1394 logitech-mouse opengl"

DEPEND=">=media-libs/freetype-2
	media-libs/fontconfig
	ssl? ( dev-libs/openssl )
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )"

RDEPEND="${DEPEND}
$(deprange $PV $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)
$(deprange $PV $MAXKDEVER kde-base/kdesu)
$(deprange $PV $MAXKDEVER kde-base/khelpcenter)
$(deprange $PV $MAXKDEVER kde-base/khotkeys)
$(deprange $PV $MAXKDEVER kde-base/libkonq)
$(deprange $PV $MAXKDEVER kde-base/kicker)"

# kdm/configure.in.in is needed for KDE_CONFDIR, can be removed for beta1
# kioslave/thumbnail/configure.in.in is needed for HAVE_LIBART, can be removed
# for beta1
KMEXTRACTONLY="kwin/kwinbindings.cpp
	    kicker/kicker/core/kickerbindings.cpp
		kicker/taskbar/taskbarbindings.cpp
	    kdesktop/kdesktopbindings.cpp
	    klipper/klipperbindings.cpp
	    kxkb/kxkbbindings.cpp
		kdm/configure.in.in
		kicker/taskmanager
	    kioslave/thumbnail/configure.in.in"

KMEXTRA="doc/kinfocenter"
KMCOMPILEONLY="kicker/libkicker
	kicker/taskbar"
KMCOPYLIB="libkonq libkonq
	libkicker kicker/libkicker
	libtaskbar kicker/taskbar
	libtaskmanager kicker/taskmanager"

src_compile() {
	myconf="$myconf `use_with ssl` `use_with arts` `use_with opengl gl`
	        `use_with ieee1394 libraw1394` `use_with logitech-mouse libusb`"
	kde-meta_src_compile
}
