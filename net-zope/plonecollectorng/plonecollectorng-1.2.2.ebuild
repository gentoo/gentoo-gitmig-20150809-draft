# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonecollectorng/plonecollectorng-1.2.2.ebuild,v 1.5 2008/05/27 06:12:19 tupone Exp $

inherit zproduct

DESCRIPTION="Bugtracking system for Plone."
HOMEPAGE="http://www.zope.org/Members/ajung/PloneCollectorNG"
SRC_URI="mirror://sourceforge/collective/PloneCollectorNG-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

RDEPEND=">=net-zope/plone-2.0.3
	>=net-zope/archetypes-1.3.0_rc2"

ZPROD_LIST="PloneCollectorNG"
