# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.3.1.ebuild,v 1.6 2004/11/17 11:27:54 kloeri Exp $

inherit kde-dist eutils

DESCRIPTION="KDE artwork package"

KEYWORDS="x86 ~amd64 sparc ppc ~ppc64 ~hppa alpha"
IUSE="opengl xscreensaver"

DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}
	!ppc64? ( xscreensaver? ( x11-misc/xscreensaver ) )"

src_unpack() {
	kde_src_unpack
	sed -ie "s:X11R6/lib\(/X11\)\?:lib:g" kscreensaver/kxsconfig/Makefile.in
}

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde_src_compile
}
