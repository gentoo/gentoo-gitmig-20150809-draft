# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfmember/cmfmember-1.0.ebuild,v 1.2 2006/01/27 02:28:46 vapier Exp $

inherit zproduct

MY_PN="CMFMember"
DESCRIPTION="CMFMember is a replacement for portal_memberdata for Zope/Plone member management"
HOMEPAGE="http://sourceforge.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/${MY_PN}-${PV}-final.tar.gz"

LICENSE="ZPL"
KEYWORDS="~x86"

RDEPEND=">=net-zope/cmf-1.4.7
	>=net-zope/plone-2.0.3
	>=net-zope/archetypes-1.3.0"

# ugly but upstreams tar balls don't contain versions
S=${WORKDIR}

ZPROD_LIST="CMFMember"
MYDOC="*.txt ${MYDOC}"
