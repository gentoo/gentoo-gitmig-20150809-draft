# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kworldclock/kdeartwork-kworldclock-3.5.2.ebuild,v 1.9 2006/09/03 13:05:05 kloeri Exp $

KMMODULE=kworldclock
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kworldwatch)"
