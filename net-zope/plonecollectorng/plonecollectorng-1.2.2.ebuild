# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonecollectorng/plonecollectorng-1.2.2.ebuild,v 1.1 2004/07/27 20:43:50 batlogg Exp $

inherit zproduct

DESCRIPTION="PCNG is a bugtracking system for Plone. It is based on the concepts and ideas of CMFCollector and CMFCollectorNG but it is a complete re-write"
HOMEPAGE="http://www.zope.org/Members/ajung/PloneCollectorNG"
SRC_URI="mirror://sourceforge/collective/PloneCollectorNG-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=">=net-zope/plone-2.0.3
		>=net-zope/archetypes-1.3.0_beta3
		${RDEPEND}"
ZPROD_LIST="PloneCollectorNG"
