# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.4.0_beta1.ebuild,v 1.1 2005/01/14 00:19:30 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE artwork package"

KEYWORDS="~x86"
IUSE="opengl xscreensaver"

DEPEND="~kde-base/kdebase-${PV}
	opengl? ( virtual/opengl )
	!ppc64? ( xscreensaver? ( x11-misc/xscreensaver ) )"

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde_src_compile
}
