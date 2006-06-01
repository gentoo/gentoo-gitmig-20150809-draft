# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxkb/kxkb-3.5.3.ebuild,v 1.1 2006/06/01 20:45:34 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5.0-patches-1.tar.bz2"

DESCRIPTION="Kxkb is a KControl module and frontend for X11 keyboard extension, allowing the user to configure and switch between keyboard mappings."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="${RDEPEND}
	|| ( (
			|| ( x11-misc/xkeyboard-config x11-misc/xkbdata )
			x11-apps/setxkbmap
		) virtual/x11 )"

KMEXTRACTONLY="${KMEXTRACTONLY}
	kdm/configure.in.in"

src_unpack() {
	unpack "kdebase-3.5.0-patches-1.tar.bz2"
	kde-meta_src_unpack

	# Avoid using imake (kde bug 114466)
	epatch "${WORKDIR}/patches/kdebase-3.5.0_beta2-noimake.patch"
}

