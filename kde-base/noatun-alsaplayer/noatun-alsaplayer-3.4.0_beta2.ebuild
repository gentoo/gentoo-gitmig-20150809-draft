# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-alsaplayer/noatun-alsaplayer-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:27 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="noatun-plugins/alsaplayer"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="noatun alsaplayer plugin"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/noatun)
		$(deprange $PV $MAXKDEVER kde-base/arts)"
OLDDEPEND="~kde-base/arts-1.3.1 ~kde-base/noatun-$PV"


