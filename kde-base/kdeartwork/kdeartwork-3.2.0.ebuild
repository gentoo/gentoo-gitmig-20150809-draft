# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.2.0.ebuild,v 1.3 2004/02/10 06:42:39 pylon Exp $
inherit kde-dist

IUSE="opengl"
DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}"

DESCRIPTION="KDE artwork package"
KEYWORDS="~x86 ~sparc ~amd64 ppc"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl"
