# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuiviewer/kuiviewer-3.4.3.ebuild,v 1.3 2005/11/25 15:00:29 cryos Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KUIViewer - Displays Designer's UI files"
KEYWORDS="amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
