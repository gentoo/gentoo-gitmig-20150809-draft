# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.0.1.ebuild,v 1.2 2004/03/26 23:28:00 batlogg Exp $

inherit zproduct

DESCRIPTION="Allows creation of new content types for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
S=${WORKDIR}/${P}
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

src_install() {
	dodoc quickref.pdf
	rm -f quickref.pdf
	zproduct_src_install
}
