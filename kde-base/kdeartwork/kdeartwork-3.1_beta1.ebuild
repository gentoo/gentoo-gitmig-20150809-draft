# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.1_beta1.ebuild,v 1.5 2002/10/05 05:39:14 drobbins Exp $

IUSE="opengl"
inherit kde-dist 

newdepend "opengl? ( virtual/opengl ) ~kde-base/kdebase-${PV}"

DESCRIPTION="KDE $PV - artwork"

KEYWORDS="x86 alpha"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 

PATCHES="$FILESDIR/xsaver-conflicting-typedefs.diff"

