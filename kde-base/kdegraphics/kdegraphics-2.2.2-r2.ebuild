# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-2.2.2-r2.ebuild,v 1.3 2003/09/09 00:48:34 usata Exp $
inherit kde-dist eutils

IUSE="tetex gphoto2"
DESCRIPTION="KDE $PV - graphics-related apps"
KEYWORDS="x86 sparc ppc"
DEPEND="$DEPEND dev-lang/perl
	media-gfx/sane-backends
	tetex? ( virtual/tetex )"

newdepend "gphoto2? ( >=media-gfx/gphoto2-2.0_beta1 )"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-${PV}-${PN}.diff
	mirror://kde/security_patches/post-${PV}-${PN}-kghostview-2.diff
	mirror://kde/security_patches/post-${PV}-${PN}-kdvi.diff"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/post-${PV}-${PN}.diff
	epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S}/kghostview
	epatch ${DISTDIR}/post-${PV}-${PN}-kghostview-2.diff
	cd ${S}/kdvi
	epatch ${DISTDIR}/post-${PV}-${PN}-kdvi.diff
}

src_compile() {
	kde_src_compile myconf

	use gphoto2 && myconf="$myconf --with-gphoto2-includes=/usr/include/gphoto2 --with-gphoto2-libraries=/usr/lib/gphoto2" || myconf="$myconf --without-kamera"
	use tetex && myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"
	kde_src_compile configure make
}
