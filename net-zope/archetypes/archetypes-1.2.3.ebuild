# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.2.3.ebuild,v 1.2 2004/06/25 01:17:28 agriffis Exp $

inherit zproduct

MY_P=${PN}-${PV}_final

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
