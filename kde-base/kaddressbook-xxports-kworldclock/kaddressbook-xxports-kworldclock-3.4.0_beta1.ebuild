# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook-xxports-kworldclock/kaddressbook-xxports-kworldclock-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:26 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/xxports/kworldclock
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KAB KWorldClock XXPort Plugin"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kaddressbook)"
OLDDEPEND="~kde-base/kaddressbook-$PV"


