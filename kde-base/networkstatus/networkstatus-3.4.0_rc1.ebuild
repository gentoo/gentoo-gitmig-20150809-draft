# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/networkstatus/networkstatus-3.4.0_rc1.ebuild,v 1.1 2005/02/27 20:21:43 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE network connection status tracking daemon"
KEYWORDS="~x86"
IUSE=""
