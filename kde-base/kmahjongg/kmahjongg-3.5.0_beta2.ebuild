# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmahjongg/kmahjongg-3.5.0_beta2.ebuild,v 1.2 2005/10/22 07:06:57 halcy0n Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)"


KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
