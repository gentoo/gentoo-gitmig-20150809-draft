# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-dub/noatun-dub-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:27 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="noatun-plugins/dub"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="noatun playlist plugin"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/noatun)"
OLDDEPEND="~kde-base/noatun-$PV"


