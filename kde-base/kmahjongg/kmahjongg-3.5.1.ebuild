# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmahjongg/kmahjongg-3.5.1.ebuild,v 1.2 2006/03/28 00:13:10 agriffis Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)"


KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
