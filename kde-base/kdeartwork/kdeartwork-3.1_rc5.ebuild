# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.1_rc5.ebuild,v 1.3 2002/12/26 00:41:46 bjb Exp $
inherit kde-dist 

IUSE="opengl"
newdepend "opengl? ( virtual/opengl ) ~kde-base/kdebase-${PV}"

DESCRIPTION="KDE artwork package"

KEYWORDS="x86 ppc sparc alpha"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 

PATCHES="$FILESDIR/xsaver-conflicting-typedefs.diff"

