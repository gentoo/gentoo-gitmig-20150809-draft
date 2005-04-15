# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.3.2.ebuild,v 1.1 2005/04/15 17:04:53 radek Exp $

inherit zproduct

MY_P=Archetypes-${PV}-final

DESCRIPTION="Allows creation of new content types for Plone"
WEBPAGE="http://www.sourceforge.net/projects/archetypes/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
#http://mesh.dl.sourceforge.net/sourceforge/archetypes/Archetypes-1.3.2-final.tar.gz
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
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
