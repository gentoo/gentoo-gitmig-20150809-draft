# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.2.0.ebuild,v 1.6 2004/02/16 19:54:30 vapier Exp $

inherit kde-dist flag-o-matic

DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc"

KEYWORDS="x86 ppc sparc ~hppa ~amd64"
IUSE="sdl svga xmms esd"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/arts-${PV//3./1.}
	esd? ( media-sound/esound )
	sdl? ( >=media-libs/libsdl-1.2 )
	svga? ( media-libs/svgalib )
	xmms? ( media-sound/xmms )"

use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

use xmms || export ac_cv_have_xmms=no

# Make vimpart use /usr/bin/kvim -- fixes bug 33257.
# This should continue to apply to upcoming versions since it's
# Gentoo-specific and won't go upstream.
PATCHES="$FILESDIR/${PN}-3.2.0-kvim.diff"
