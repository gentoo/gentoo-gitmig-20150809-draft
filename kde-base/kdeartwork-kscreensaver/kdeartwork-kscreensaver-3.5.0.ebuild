# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-3.5.0.ebuild,v 1.1 2005/11/22 22:14:00 danarmak Exp $

KMMODULE=kscreensaver
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~amd64 ~x86"
IUSE="opengl xscreensaver"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kscreensaver)
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_compile() {
	local myconf="$myconf --with-dpms --with-libart
	              $(use_with opengl gl) $(use_with xscreensaver)"

	kde-meta_src_compile
}
