# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.0.5a.ebuild,v 1.1 2002/12/21 13:48:19 hannes Exp $
inherit kde-dist flag-o-matic

DESCRIPTION="KDE $PV: addons - applets, plugins..."
KEYWORDS="x86 ~ppc ~alpha"

newdepend "~kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdemultimedia-${PV}
	sdl? ( >=media-libs/libsdl-1.2 )
	svga? ( media-libs/svgalib )"

use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

# fix bug #7625
if [ "$COMPILER" == "gcc3" ]; then
    if [ -n "`is-flag -march=pentium4`" -o -n "`is-flag -mcpu=pentium4`" ]; then
	append-flags -mno-sse2
    fi
fi
