# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.0.1.ebuild,v 1.1 2002/05/13 19:42:32 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Addons"

newdepend ">=kde-base/kdebase-${PV}
	~kde-base/kdenetwork-${PV}
	~kde-base/kdemultimedia-${PV}
	>=media-libs/libsdl-1.2
	sdl? ( media-libs/libsdl )"

#myconf="$myconf --with-extra-includes=/usr/include/noatun"
use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"

# needed for some stupid noatun plugins that can't find arts include file reference.h, which lives in /usr/kde/3/include/arts
#myconf="$myconf --with-extra-includes=/usr/kde/3/include/arts"

src_unpack2() {

    base_src_unpack
    
    cd ${S}/noatun-plugins
    for x in `find -iname Makefile.am` `find -iname Makefile.in`; do
	echo "(Maybe) patching ${x}..."
	cp ${x} ${x}2
	sed -e "s:\$(kde_libraries)/libnoatun.so:${KDEDIR}/lib/libnoatun.so:" ${x}2 > ${x}
	rm ${x}2
    done

}

