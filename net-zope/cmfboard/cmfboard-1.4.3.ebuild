# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfboard/cmfboard-1.4.3.ebuild,v 1.5 2006/01/27 02:27:23 vapier Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product which provides a forum"
HOMEPAGE="http://www.cmfboard.org"
SRC_URI="http://www.cmfboard.org/download/CMFBoard-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

RDEPEND=">=net-zope/cmf-1.3.3
	>=net-zope/plone-1.0.5
	>=net-zope/archetypes-1.0.1"

ZPROD_LIST="CMFBoard"
