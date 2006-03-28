# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksim/ksim-3.5.0.ebuild,v 1.6 2006/03/28 00:43:46 agriffis Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Monitor applets"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="snmp"
DEPEND="snmp? ( net-analyzer/net-snmp )"

myconf="$myconf $(use_with snmp)"
