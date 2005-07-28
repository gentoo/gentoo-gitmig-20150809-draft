# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscreensaver/kscreensaver-3.4.2.ebuild,v 1.1 2005/07/28 21:16:22 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE screensaver framework"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="opengl"
DEPEND="opengl? ( virtual/opengl )
	media-libs/libart_lgpl" # The below patch provides a configure switch, but we've no USE flag for libart
PATCHES="$FILESDIR/configure-fix-kdeartwork-libart.patch"

src_compile() {
	myconf="$myconf `use_with opengl gl`"
	kde-meta_src_compile
}
