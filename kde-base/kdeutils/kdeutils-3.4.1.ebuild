# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.4.1.ebuild,v 1.4 2005/07/04 23:00:34 kloeri Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86"
IUSE="crypt snmp"

DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

src_compile() {
	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}
