# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.2.0_beta2.ebuild,v 1.5 2004/01/04 15:28:24 weeve Exp $
inherit kde-dist flag-o-matic

IUSE="sdl svga xmms esd"
DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc"
KEYWORDS="~x86 ~sparc"
DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/arts-${PV//3./1.}
	esd? ( media-sound/esound )
	sdl? ( >=media-libs/libsdl-1.2 )
	svga? ( media-libs/svgalib )
	xmms? ( media-sound/xmms )"
RDEPEND="$DEPEND"

use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

use xmms || export ac_cv_have_xmms=no
