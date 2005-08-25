# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.4.1.ebuild,v 1.9 2005/08/25 19:37:03 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE artwork package"

KEYWORDS="~alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE="opengl xscreensaver"

DEPEND="~kde-base/kdebase-${PV}
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_unpack() {
	kde_src_unpack

	# Fix compilation with --without-gl and detection of arts.
	# See kde bug 89387 and 102398. Applied for 3.4.2.
	epatch ${FILESDIR}/${P}-configure.patch

	make -f admin/Makefile.common
}

src_compile() {
	myconf="--with-dpms $(use_with opengl gl)"

	kde_src_compile
}
