# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.5.5-r2.ebuild,v 1.12 2007/03/08 20:27:47 caleb Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="3.5.5-r7 $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xcomposite"
RDEPEND="xcomposite? ( x11-libs/libXcomposite x11-libs/libXdamage )"
DEPEND="${RDEPEND}"

SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-seli-xinerama.patch.bz2"

PATCHES="${FILESDIR}/${P}-input-shape.patch
	${DISTDIR}/${P}-seli-xinerama.patch.bz2"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
