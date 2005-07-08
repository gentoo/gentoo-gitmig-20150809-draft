# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscreensaver/kscreensaver-3.4.1.ebuild,v 1.6 2005/07/08 02:50:53 weeve Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE screensaver framework"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="opengl"

DEPEND="opengl? ( virtual/opengl )"

src_compile() {
	myconf="$myconf `use_with opengl gl`"
	kde-meta_src_compile
}
