# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker-scripts/knewsticker-scripts-3.4.3.ebuild,v 1.5 2005/12/09 04:44:48 josejx Exp $
KMNAME=kdeaddons
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Kicker applet - RSS news ticker"
KEYWORDS="~alpha amd64 ppc ppc64 sparc ~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/knewsticker)"
OLDDEPEND="~kde-base/knewsticker-$PV"


