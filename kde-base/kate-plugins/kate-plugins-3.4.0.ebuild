# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate-plugins/kate-plugins-3.4.0.ebuild,v 1.3 2005/03/25 00:54:49 weeve Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kate"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kate plugins and docs"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kate)"
OLDDEPEND="~kde-base/kate-$PV"
