# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/mpoll/mpoll-0.3.1.ebuild,v 1.2 2004/06/25 01:22:40 agriffis Exp $

inherit zproduct

DESCRIPTION="MPoll provides a polling product for Plone."
HOMEPAGE="http://www.sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/MPoll-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=net-zope/plone-1.0.1
	>=net-zope/archetypes-0.9
	${RDEPEND}"

ZPROD_LIST="MPoll"
