 
# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ttwtype/ttwtype-0.9.1.ebuild,v 1.2 2003/04/06 03:13:42 kutsuya Exp $

inherit zproduct

DESCRIPTION="Create new content types via the ZMI for plone."
HOMEPAGE="http://www.zope.org/Members/comlounge/TTWType/"
SRC_URI="${HOMEPAGE}TTWType-${PV}.tgz"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"

RDEPEND=">=net-zope/plone-1.0.1
	${RDEPEND}"

ZPROD_LIST="TTWType"