# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.4.0_beta2.ebuild,v 1.3 2005/02/19 13:51:18 greg_g Exp $

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
	epatch ${FILESDIR}/${P}-gl-kdesavers.patch

	make -f admin/Makefile.common
}

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde_src_compile
}

src_install() {
	kde_src_install

	# collision with kdelibs, fixed in rc1
	rm -r ${D}/${KDEDIR}/share/emoticons/Default
}
