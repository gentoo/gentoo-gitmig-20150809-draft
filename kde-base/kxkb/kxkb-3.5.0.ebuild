# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxkb/kxkb-3.5.0.ebuild,v 1.7 2005/12/19 19:07:01 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kicker applet for management of X keymaps"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	|| ( (
			x11-misc/xkbdata 
			x11-apps/setxkbmap
		) virtual/x11 )"

PATCHES="${FILESDIR}/${P}-modularxkb.patch"

