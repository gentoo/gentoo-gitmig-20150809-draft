# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.3.1.ebuild,v 1.1 2004/12/04 20:15:27 radek Exp $

inherit zproduct

MY_P=Archetypes-1.3.1-final

DESCRIPTION="Allows creation of new content types for Plone"
WEBPAGE="http://www.sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="1.3"

RDEPEND=">=net-zope/cmf-1.4.7
		 =net-zope/portaltransforms-1.3*
		 =net-zope/generator-1.3*
		 =net-zope/validation-1.3*
		 =net-zope/mimetypesregistry-1.3*

		${RDEPEND}"

ZPROD_LIST="Archetypes"

src_install()
{
	zproduct_src_install all
}
