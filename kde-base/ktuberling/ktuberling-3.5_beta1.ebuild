# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktuberling/ktuberling-3.5_beta1.ebuild,v 1.2 2005/10/22 07:36:57 halcy0n Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: potato game for kids"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)"
OLDDEPEND="~kde-base/libkdegames-$PV"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
