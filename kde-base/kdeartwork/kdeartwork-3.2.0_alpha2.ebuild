# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.2.0_alpha2.ebuild,v 1.3 2003/10/23 17:45:37 caleb Exp $
inherit kde-dist

IUSE="opengl"
#newdepend "opengl? ( virtual/opengl ) =kde-base/kdebase-${PV}*"
newdepend "opengl? ( virtual/opengl ) kde-base/kdebase"

DESCRIPTION="KDE artwork package"
KEYWORDS="~x86"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl"
