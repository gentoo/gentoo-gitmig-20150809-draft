# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksim/ksim-3.4.3.ebuild,v 1.9 2006/06/22 12:59:48 flameeyes Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Monitor applets"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="snmp"
DEPEND="snmp? ( net-analyzer/net-snmp )"

PATCHES="$FILESDIR/configure-fix-kdeutils-snmp.patch"

src_compile() {
	myconf="$myconf $(use_with snmp)"
	kde-meta_src_compile
}
