# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.2.0_rc1.ebuild,v 1.1 2004/01/19 03:39:15 caleb Exp $
inherit kde-dist

IUSE="opengl"
DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}"

DESCRIPTION="KDE artwork package"
KEYWORDS="~x86 ~sparc ~amd64"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl"
