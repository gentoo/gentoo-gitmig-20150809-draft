# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/issuetrackerproduct/issuetrackerproduct-0.5.2.ebuild,v 1.1 2004/10/23 22:53:54 lanius Exp $

inherit zproduct

DESCRIPTION="Issue tracking system."
HOMEPAGE="http://www.zope.org/Members/peterbe/IssueTrackerProduct"
SRC_URI="${HOMEPAGE}/${PV}/IssueTrackerProduct-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=dev-python/stripogram-1.4
	${RDEPEND}"

ZPROD_LIST="IssueTrackerProduct"
IUSE=""
