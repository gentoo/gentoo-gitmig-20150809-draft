# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.1_beta2.ebuild,v 1.5 2002/10/08 21:13:25 danarmak Exp $

IUSE="sdl xmms svga"
inherit kde-dist flag-o-matic

DESCRIPTION="KDE $PV: addons - applets, plugins..."
KEYWORDS="x86"

newdepend "~kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	sdl? ( >=media-libs/libsdl-1.2 )
	svga? ( media-libs/svgalib )
	xmms? ( media-sound/xmms )"

use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

use xmms || export ac_cv_have_xmms=no

# fix bug #7625
if [ "$COMPILER" == "gcc3" ]; then
    if [ -n "`is-flag -march=pentium4`" -o -n "`is-flag -mcpu=pentium4`" ]; then
	append-flags -mno-sse2
    fi
fi
