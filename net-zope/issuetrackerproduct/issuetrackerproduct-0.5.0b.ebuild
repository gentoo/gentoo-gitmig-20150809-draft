# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/issuetrackerproduct/issuetrackerproduct-0.5.0b.ebuild,v 1.4 2003/09/08 06:53:30 msterret Exp $

inherit zproduct

DESCRIPTION="Issue tracking system."
HOMEPAGE="http://www.zope.org/Members/peterbe/IssueTrackerProduct"
SRC_URI="${HOMEPAGE}/IssueTrackerProduct-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ppc"
# Wondering if these should be turned into local USE flags.
RDEPEND=">=dev-python/email-py21-2.5
	>=dev-python/stripogram-py21-1.4
	${RDEPEND}"

ZPROD_LIST="IssueTrackerProduct"
