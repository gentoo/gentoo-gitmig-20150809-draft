# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.0.3.ebuild,v 1.1 2004/07/27 20:28:04 batlogg Exp $

SLOT="2.0"

inherit zproduct

DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/PloneBase-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=">=net-zope/cmf-1.4.4
	>=net-zope/btreefolder2-1.0
	>=net-zope/cmfactionicons-0.9
	>=net-zope/cmfformcontroller-1.0.2
	>=net-zope/cmfquickinstallertool-1.5.0
	>=net-zope/formulator-1.6.2
	>=net-zope/groupuserfolder-2.0.1
	>=net-zope/placelesstranslationservice-fork-1.0_rc7
	>=net-zope/ploneerrorreporting-0.1
	>=net-zope/archetypes-1.2.5_rc4
	>=net-zope/portaltransforms-1.0.4
	>=net-zope/externaleditor-0.7.2
	>=net-zope/epoz-0.8.0
	${RDEPEND}"

# TODO: check plonetranslations

ZPROD_LIST="CMFPlone"
