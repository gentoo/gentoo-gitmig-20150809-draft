# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.4.0_beta1.ebuild,v 1.2 2005/01/15 00:14:44 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="~x86"
IUSE="crypt snmp"

DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

src_compile() {
	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	# ugly hack: net-snmp provides a prototype for strlcpy for packages
	# that link against it, but kdeutils too provides a prototype for
	# strlcpy in config.h since it can't find one.
	use snmp && export kde_cv_proto_strlcpy=no

	kde_src_compile
}
