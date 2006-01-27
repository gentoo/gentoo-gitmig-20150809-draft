# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ttwtype/ttwtype-0.9.1.ebuild,v 1.5 2006/01/27 02:48:27 vapier Exp $

inherit zproduct

DESCRIPTION="Create new content types via the ZMI for plone"
HOMEPAGE="http://www.zope.org/Members/comlounge/TTWType/"
SRC_URI="${HOMEPAGE}TTWType-${PV}.tgz"

LICENSE="BSD"
KEYWORDS="~ppc x86"

RDEPEND=">=net-zope/plone-1.0.1"

ZPROD_LIST="TTWType"
