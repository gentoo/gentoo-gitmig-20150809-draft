# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-pitchablespeed/noatun-pitchablespeed-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:41 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="noatun-plugins/pitchablespeed"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="noatun plugin for changing playing speed of audio"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/noatun)
	$(deprange $PV $MAXKDEVER kde-base/arts)"
OLDDEPEND="~kde-base/arts-1.3.1 ~kde-base/noatun-$PV"


