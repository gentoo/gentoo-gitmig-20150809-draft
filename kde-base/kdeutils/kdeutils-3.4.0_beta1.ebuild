# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.4.0_beta1.ebuild,v 1.5 2005/02/02 11:50:07 lanius Exp $

inherit kde-dist eutils

DESCRIPTION="KDE utilities"

KEYWORDS="~x86 ~amd64"
IUSE="crypt snmp"

DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

src_unpack() {
	kde_src_unpack

	# applied upstream, will be in beta2
	epatch ${FILESDIR}/${P}-snmpfix.patch
}

src_compile() {
	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}
