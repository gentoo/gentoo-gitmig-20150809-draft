# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin4/kwin4-3.5.2.ebuild,v 1.1 2006/03/22 20:15:41 danarmak Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kde four-in-a-row game"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange 3.5.1 $MAXKDEVER kde-base/libkdegames)"


KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
