# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/atlantik/atlantik-3.5.2.ebuild,v 1.8 2006/06/01 05:21:20 tcort Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="The Atlantic board game"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="
$(deprange 3.5.1 $MAXKDEVER kde-base/libkdegames)"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
