# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.0.ebuild,v 1.4 2002/04/20 22:18:57 rphillips Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist 

newdepend "opengl? ( virtual/opengl )"

DESCRIPTION="${DESCRIPTION}Artwork"

src_compile() {
    kde_src_compile myconf
    
    myconf="$myconf --with-dpms"
    use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 
	myconf="$myconf --without-gl"
    
    kde_src_compile configure make
}

src_install() {
	dodir ${KDEDIR}/share/apps/kthememgr/Themes
	kde_src_install all
}
