# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/speedpack/speedpack-0.3.ebuild,v 1.1 2005/05/14 12:25:50 radek Exp $

inherit zproduct

DESCRIPTION="Increase plone performance by caching page templates and use of pscyo"
HOMEPAGE="http://plone.org/collective"
SRC_URI="mirror://sourceforge/collective/SpeedPack-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/psyco"
RDEPEND=""

ZPROD_LIST="SpeedPack"

