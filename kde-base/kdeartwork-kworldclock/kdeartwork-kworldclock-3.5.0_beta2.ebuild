# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kworldclock/kdeartwork-kworldclock-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:40:43 halcy0n Exp $

KMMODULE=kworldclock
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kworldwatch)"
