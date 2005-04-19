# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/issuetrackerproduct/issuetrackerproduct-0.6.5.ebuild,v 1.1 2005/04/19 17:43:42 radek Exp $

inherit zproduct

DESCRIPTION="Friendly Issue tracking system for Zope."
HOMEPAGE="http://www.issuetrackerproduct.com"
SRC_URI="${HOMEPAGE}/Download/IssueTrackerProduct-${PV}.tgz"

LICENSE="ZPL"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

RDEPEND=">=dev-python/stripogram-1.4
	${RDEPEND}"

ZPROD_LIST="IssueTrackerProduct"
