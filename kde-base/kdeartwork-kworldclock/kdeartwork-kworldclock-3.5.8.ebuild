# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kworldclock/kdeartwork-kworldclock-3.5.8.ebuild,v 1.7 2008/03/04 04:23:13 jer Exp $

ARTS_REQUIRED="never"

KMMODULE=kworldclock
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kworldclock)"
