# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.3.0_beta3.ebuild,v 1.1 2004/07/27 18:56:48 batlogg Exp $

inherit zproduct

#MY_P=${PN}-1.3.0-beta3
MY_P=Archetypes-1.3.0-beta3

DESCRIPTION="Allows creation of new content types for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=net-zope/plone-2.0.3
		${RDEPEND}"

#RDEPEND=">=net-zope/plone-2.0.3
#		>=net-zope/portaltransforms-1.0.4
#		>=net-zope/validation-1.1.0
#		>=net-zope/generator-1.0.2
#		>=net-zope/mimetypesregistry-1.3.0-1
#		${RDEPEND}"

# waiting for the releases to separate the dependent products to their own ebuilds...

ZPROD_LIST="Archetypes ArchExample ArchGenXML generator validation PortalTransforms MimetypesRegistry"

src_install()
{
#    rm -r ArchExample ArchGenXML generator validation
#	Formulator/
	zproduct_src_install all
}
