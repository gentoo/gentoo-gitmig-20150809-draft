# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksim/ksim-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:23 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Monitor applets"
KEYWORDS="~x86"
IUSE="snmp"

DEPEND="snmp? ( net-analyzer/net-snmp )"

src_unpack() {
	kde-meta_src_unpack

	# applied upstream, will be in beta2
	epatch ${FILESDIR}/${P}-snmpfix.patch
}
