# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfboard/cmfboard-2.1.2.ebuild,v 1.2 2006/01/27 02:27:23 vapier Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product which provides a forum"
HOMEPAGE="http://www.cmfboard.org"
SRC_URI="mirror://sourceforge/collective/CMFBoard-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

RDEPEND=">=net-zope/cmf-1.4.4
	>=net-zope/plone-2.0
	>=net-zope/archetypes-1.2.5_rc4"

ZPROD_LIST="CMFBoard"
