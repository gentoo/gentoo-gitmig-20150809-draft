# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.0.ebuild,v 1.1 2003/10/11 09:02:08 robbat2 Exp $

inherit zproduct

MY_PV=${PV//./_}-final
MY_P=${PN}-${MY_PV}
DESCRIPTION="Allows creation of new content types for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
S=${WORKDIR}/${MY_P}
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=net-zope/plone-1.0.1
		dev-python/generator
		dev-python/validation
		net-zope/portaltransforms
		${RDEPEND}"

ZPROD_LIST="Archetypes ArchExample ArchGenXML"

src_unpack() {
	unpack ${A}
	rm -rf ${S}/{generator,validation}
}
