# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpat/kpat-3.4.3.ebuild,v 1.8 2006/03/25 03:46:28 agriffis Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE patience game"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
OLDDEPEND="~kde-base/libkdegames-3.3.1"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkdegames)"

RDEPEND="${DEPEND}
	$(deprange-dual $PV $MAXKDEVER kde-base/kdebase-data)"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
