# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksim/ksim-3.4.0.ebuild,v 1.3 2005/03/25 04:03:41 weeve Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Monitor applets"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="snmp"

DEPEND="snmp? ( net-analyzer/net-snmp )"

