# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ttwtype/ttwtype-0.9.1.ebuild,v 1.4 2004/06/25 01:25:51 agriffis Exp $

inherit zproduct

DESCRIPTION="Create new content types via the ZMI for plone."
HOMEPAGE="http://www.zope.org/Members/comlounge/TTWType/"
SRC_URI="${HOMEPAGE}TTWType-${PV}.tgz"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"

RDEPEND=">=net-zope/plone-1.0.1
	${RDEPEND}"

ZPROD_LIST="TTWType"
