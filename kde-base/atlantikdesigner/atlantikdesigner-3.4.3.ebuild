# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/atlantikdesigner/atlantikdesigner-3.4.3.ebuild,v 1.3 2005/11/24 20:41:49 corsair Exp $
KMNAME=kdeaddons
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Atlantik gameboard designer"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/atlantik)"
OLDDEPEND="~kde-base/atlantik-$PV"


