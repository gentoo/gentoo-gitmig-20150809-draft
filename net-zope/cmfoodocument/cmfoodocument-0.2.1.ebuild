# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfoodocument/cmfoodocument-0.2.1.ebuild,v 1.1 2004/01/28 15:01:22 lanius Exp $

inherit zproduct

MY_PV=0_2_1

DESCRIPTION="Zope/CMF for handling OpenOffice documents"
HOMEPAGE="http://www.zope.org/Members/longsleep/CMFOODocument"
SRC_URI="http://www.zope.org/Members/longsleep/CMFOODocument/${PV}/CMFOODocument-${MY_PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86"
RDEPEND="net-zope/cmf
	>=net-zope/plone-1.0.1
	dev-libs/libxml2
	dev-libs/libxslt
	${RDEPEND}"

ZPROD_LIST="CMFOODocument"
