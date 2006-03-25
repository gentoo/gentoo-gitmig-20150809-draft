# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-3.4.3.ebuild,v 1.9 2006/03/25 02:52:13 agriffis Exp $

KMMODULE=kscreensaver
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="opengl xscreensaver"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kscreensaver)
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

PATCHES="${FILESDIR}/kdeartwork-3.4.3-configure.patch"

# Fix Makefile. Applied for 3.4.4.
PATCHES="${PATCHES} ${FILESDIR}/kdeartwork-3.4.3-kfiresaver.patch"

src_compile() {
	local myconf="$myconf --with-dpms --with-libart
	              $(use_with opengl gl) $(use_with xscreensaver)"

	kde-meta_src_compile
}
