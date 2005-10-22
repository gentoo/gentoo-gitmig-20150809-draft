# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kworldwatch/kworldwatch-3.5_beta1.ebuild,v 1.2 2005/10/22 07:42:22 halcy0n Exp $

KMNAME=kdetoys
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE program that displays the part of the Earth lit up by the Sun"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

# kworldwatch is more commonly known as kworldclock
KMEXTRA="doc/kworldclock"

