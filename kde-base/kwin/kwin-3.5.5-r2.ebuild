# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.5.5-r2.ebuild,v 1.5 2007/01/04 11:31:02 gustavoz Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="3.5.5-r7 $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xcomposite"
RDEPEND="xcomposite? (
	x11-libs/libXcomposite
	x11-libs/libXdamage
	)"
DEPEND="${RDEPEND}
	xcomposite? (
		x11-proto/compositeproto
		x11-proto/damageproto
	)"

SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-seli-xinerama.patch.bz2"

PATCHES="${FILESDIR}/${P}-input-shape.patch
	${DISTDIR}/${P}-seli-xinerama.patch.bz2"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
