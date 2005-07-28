# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knewsticker-scripts/knewsticker-scripts-3.4.1.ebuild,v 1.8 2005/07/28 21:16:19 danarmak Exp $
KMNAME=kdeaddons
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Kicker applet - RSS news ticker"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange-dual $PV 3.4.2 kde-base/knewsticker)"
OLDDEPEND="~kde-base/knewsticker-$PV"


