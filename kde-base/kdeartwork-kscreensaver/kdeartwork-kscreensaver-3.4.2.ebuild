# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-3.4.2.ebuild,v 1.2 2005/07/30 08:20:49 greg_g Exp $

KMMODULE=kscreensaver
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="opengl xscreensaver"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kscreensaver)
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

PATCHES1="${FILESDIR}/kdeartwork-3.4-configure.patch"

src_compile() {
	local myconf="$myconf --with-dpms --with-libart
	              $(use_with opengl gl)"

	if use xscreensaver; then
		myconf="${myconf} --with-xscreensaver
		        --with-xscreensaver-dir=/usr/lib/misc/xscreensaver
		        --with-xscreensaver-config=/usr/share/xscreensaver/config"
	else
		myconf="${myconf} --without-xscreensaver"
	fi

	kde-meta_src_compile
}
