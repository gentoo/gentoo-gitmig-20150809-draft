# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.0.5-r2.ebuild,v 1.1 2006/04/16 11:31:08 radek Exp $

inherit zproduct eutils

DESCRIPTION="A Zope Content Management System, based on Zope CMF"
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/PloneBase-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="2.0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="=net-zope/cmf-1.4*
	=net-zope/zope-2.7*
	>=net-zope/btreefolder2-1.0.1
	>=net-zope/cmfactionicons-0.9
	>=net-zope/cmfformcontroller-1.0.2
	>=net-zope/cmfquickinstallertool-1.5.0
	>=net-zope/formulator-1.6.2
	>=net-zope/groupuserfolder-2.0.1
	>=net-zope/placelesstranslationservice-fork-1.0_rc7
	>=net-zope/ploneerrorreporting-0.11
	>=net-zope/plonetranslations-0.5
	>=net-zope/archetypes-1.2.5_rc5
	>=net-zope/portaltransforms-1.0.4
	>=net-zope/externaleditor-0.8
	>=net-zope/epoz-0.8.2
	>=app-admin/zope-config-0.5
	>=dev-lang/python-2.3"

ZPROD_LIST="CMFPlone"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-portrait_security.patch
}

