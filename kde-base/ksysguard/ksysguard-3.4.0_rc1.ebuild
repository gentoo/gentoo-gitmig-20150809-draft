# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.4.0_rc1.ebuild,v 1.1 2005/02/27 20:21:40 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Guard"
KEYWORDS="~x86"
IUSE="lm_sensors"
DEPEND="lm_sensors? ( sys-apps/lm-sensors )"

