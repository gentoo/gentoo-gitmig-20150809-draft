# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.0-r1.ebuild,v 1.3 2002/05/21 18:14:10 danarmak Exp $

inherit kde-dist 

newdepend "opengl? ( virtual/opengl )"

DESCRIPTION="${DESCRIPTION}Artwork"

src_compile() {
	# added to fix GL problems within xscreensavers
	patch -p1 < ${FILESDIR}/kdeartwork-screensaver.patch

    kde_src_compile myconf
    
    myconf="$myconf --with-dpms"
    use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 
    
    kde_src_compile configure make
}

src_install() {
	dodir ${KDEDIR}/share/apps/kthememgr/Themes
	kde_src_install all
}
