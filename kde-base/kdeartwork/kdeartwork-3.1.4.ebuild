# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.1.4.ebuild,v 1.9 2004/01/13 16:53:21 agriffis Exp $
inherit kde-dist

IUSE="opengl"
DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}"
RDEPEND="$DEPEND"

DESCRIPTION="KDE artwork package"
KEYWORDS="x86 ppc sparc hppa amd64 alpha"
PATCHES="$FILESDIR/xsaver-conflicting-typedefs.diff"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl"
