# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscreensaver/kscreensaver-3.5.5.ebuild,v 1.9 2006/12/11 11:57:55 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE screensaver framework"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility opengl"
DEPEND="opengl? ( virtual/opengl )"

RDEPEND="${DEPEND}"

src_compile() {
	myconf="$myconf `use_with opengl gl`"
	kde-meta_src_compile
}
