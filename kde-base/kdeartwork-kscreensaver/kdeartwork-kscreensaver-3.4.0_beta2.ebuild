# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:14 danarmak Exp $

KMMODULE=kscreensaver
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~x86"
IUSE="opengl xscreensaver"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kscreensaver)
	opengl? ( virtual/opengl )
	!ppc64? ( xscreensaver? ( x11-misc/xscreensaver ) )"

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde-meta_src_compile
}
