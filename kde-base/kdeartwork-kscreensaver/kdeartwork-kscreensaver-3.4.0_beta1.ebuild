# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:29 danarmak Exp $

KMMODULE=kscreensaver
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~x86"
IUSE="opengl xscreensaver"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kscreensaver)
	opengl? ( virtual/opengl )
	!ppc64 ( xscreensaver? ( x11-misc/xscreensaver ) )"

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde-meta_src_compile
}
