# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.2.0_beta1.ebuild,v 1.4 2004/01/05 23:33:58 robbat2 Exp $
inherit kde-dist flag-o-matic

IUSE="sdl svga xmms"
DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc"
KEYWORDS="~x86"

newdepend "~kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/arts-${PV//3./1.}
	sdl? ( >=media-libs/libsdl-1.2 )
	svga? ( media-libs/svgalib )
	xmms? ( media-sound/xmms )"

use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

use xmms || export ac_cv_have_xmms=no
