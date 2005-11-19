# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxkb/kxkb-3.5.0_rc1.ebuild,v 1.2 2005/11/19 23:58:55 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kicker applet for management of X keymaps"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Make sure that modularx share dir is checked while using kxkb. Already
# committed for 3.5.0 final.
PATCHES="${FILESDIR}/${P}-modularx.patch"
