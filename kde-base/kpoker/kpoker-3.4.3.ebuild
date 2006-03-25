# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpoker/kpoker-3.4.3.ebuild,v 1.8 2006/03/25 03:26:27 agriffis Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE poker game"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
OLDDEPEND="~kde-base/libkdegames-3.3.1"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkdegames)"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
