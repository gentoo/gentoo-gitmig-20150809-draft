# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.2.0_beta2.ebuild,v 1.2 2003/12/28 03:50:44 caleb Exp $
inherit kde-dist

IUSE="opengl"
DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}"

DESCRIPTION="KDE artwork package"
KEYWORDS="~x86"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl"
