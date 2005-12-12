# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lskat/lskat-3.5.0.ebuild,v 1.4 2005/12/12 16:12:21 josejx Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE card game"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)"


KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
