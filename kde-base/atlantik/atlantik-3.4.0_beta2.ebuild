# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/atlantik/atlantik-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:10 danarmak Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="The Atlantic board game"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/libkdegames-3.3.1"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkdegames)"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
