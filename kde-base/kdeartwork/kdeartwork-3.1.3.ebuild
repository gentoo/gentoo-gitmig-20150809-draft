# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.1.3.ebuild,v 1.3 2003/08/13 12:25:10 weeve Exp $
inherit kde-dist 

IUSE="opengl"
newdepend "opengl? ( virtual/opengl ) =kde-base/kdebase-${PV}*"

DESCRIPTION="KDE artwork package"
KEYWORDS="~x86 ~ppc ~sparc"
PATCHES="$FILESDIR/xsaver-conflicting-typedefs.diff"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 
