# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.4.0.ebuild,v 1.1 2005/03/14 21:47:05 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE artwork package"

KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="opengl xscreensaver"

DEPEND="~kde-base/kdebase-${PV}
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_unpack() {
	kde_src_unpack

	# Fix compilation with --without-gl. See bug #46775 and kde bug 89387.
	epatch ${FILESDIR}/kdeartwork-3.4.0_beta2-gl-kdesavers.patch

	make -f admin/Makefile.common
}

src_compile() {
	myconf="--with-dpms $(use_with opengl gl)"

	kde_src_compile
}
