# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/mpoll/mpoll-0.3.1.ebuild,v 1.3 2006/01/27 02:38:25 vapier Exp $

inherit zproduct

DESCRIPTION="MPoll provides a polling product for Plone"
HOMEPAGE="http://www.sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/MPoll-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=net-zope/plone-1.0.1
	>=net-zope/archetypes-0.9"

ZPROD_LIST="MPoll"
