# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfboard/cmfboard-2.1.2.ebuild,v 1.1 2004/09/11 22:42:00 lanius Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product which provides a forum"
HOMEPAGE="http://www.cmfboard.org"
SRC_URI="mirror://sourceforge/collective/CMFBoard-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=net-zope/cmf-1.4.4
	>=net-zope/plone-2.0
	>=net-zope/archetypes-1.2.5_rc4
	${RDEPEND}"

ZPROD_LIST="CMFBoard"
IUSE=""
