# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-2.2.1-r1.ebuild,v 1.3 2001/11/19 15:09:31 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Addons"

NEWDEPEND=">=kde-base/kdebase-${PV}
	    >=kde-base/kdenetwork-${PV}
	    >=kde-base/kdemultimedia-${PV}
    	    >=media-libs/libsdl-1.2"

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"

src_unpack() {

    base_src_unpack all
    
    cd ${S}/noatun-plugins
    for x in `find -iname Makefile.am` `find -iname Makefile.in`; do
	echo "(Maybe) patching ${x}..."
	cp ${x} ${x}2
	sed -e 's:$(kde_libraries)/libnoatun.so:/usr/lib/libnoatun.so:' ${x}2 > ${x}
	rm ${x}2
    done

}

src_compile() {
    kde_src_compile myconf
    myconf="$myconf --with-extra-includes=/usr/include/noatun"
    kde_src_compile configure make
}
