# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfouleggs/kfouleggs-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:17 danarmak Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE games: KFoulEggs is an adaptation of the well-known (at least in Japan) PuyoPuyo game"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)
$(deprange $PV $MAXKDEVER kde-base/libksirtet)"
OLDDEPEND="~kde-base/libkdegames-$PV ~kde-base/libksirtet-$PV"

KMEXTRACTONLY=libkdegames
KMCOMPILEONLY=libksirtet
KMCOPYLIB="libkdegames libkdegames"
