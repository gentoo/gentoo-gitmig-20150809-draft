# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lskat/lskat-3.4.3.ebuild,v 1.4 2005/11/25 01:04:07 cryos Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE card game"
KEYWORDS="~alpha amd64 ~ppc ppc64 sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)"
OLDDEPEND="~kde-base/libkdegames-$PV"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
