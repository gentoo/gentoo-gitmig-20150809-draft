# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.0.1.20020604.ebuild,v 1.4 2002/06/25 23:51:36 gerk Exp $

inherit kde-patch kde-dist || die

DESCRIPTION="${DESCRIPTION}Addons"

newdepend ">=kde-base/kdebase-${PV}
	>=kde-base/kdenetwork-${PV}
	>=kde-base/kdemultimedia-${PV}
	sdl? ( >=media-libs/libsdl-1.2 )
	svga? ( media-libs/svgalib )"

use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

# This is a fix used for a makefile/linking problem when destdir=!kdelibsdir. I haven't tested it
# with 3.0.1, don't know if it's still necessary.
#src_unpack() {
#
#    base_src_unpack
#    
#    cd ${S}/noatun-plugins
#    for x in `find -iname Makefile.am` `find -iname Makefile.in`; do
#	echo "(Maybe) patching ${x}..."
#	cp ${x} ${x}2
#	sed -e "s:\$(kde_libraries)/libnoatun.so:${KDEDIR}/lib/libnoatun.so:" ${x}2 > ${x}
#	rm ${x}2
#    done
#
#}

