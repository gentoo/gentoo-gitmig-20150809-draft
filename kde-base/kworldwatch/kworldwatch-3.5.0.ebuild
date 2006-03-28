# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kworldwatch/kworldwatch-3.5.0.ebuild,v 1.6 2006/03/28 01:05:52 agriffis Exp $

KMNAME=kdetoys
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE program that displays the part of the Earth lit up by the Sun"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=""

# kworldwatch is more commonly known as kworldclock
KMEXTRA="doc/kworldclock"

