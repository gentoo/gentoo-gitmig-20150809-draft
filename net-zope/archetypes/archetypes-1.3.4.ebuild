# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.3.4.ebuild,v 1.1 2006/12/28 23:34:21 radek Exp $

inherit zproduct

MY_P=Archetypes-${PV}-final
DESCRIPTION="Allows creation of new content types for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/archetypes/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.3"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=net-zope/cmf-1.4.7
	 =net-zope/portaltransforms-1.3*
	 =net-zope/generator-1.3*
	 =net-zope/validation-1.3*
	 =net-zope/mimetypesregistry-1.3*"

ZPROD_LIST="Archetypes"

src_install() {
	zproduct_src_install all
}
