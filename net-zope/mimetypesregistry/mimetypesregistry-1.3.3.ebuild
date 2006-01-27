# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/mimetypesregistry/mimetypesregistry-1.3.3.ebuild,v 1.4 2006/01/27 02:38:05 vapier Exp $

inherit zproduct

MY_P=MimetypesRegistry-1.3.3-final
DESCRIPTION="Mimetypes Registry for Archetypes and PortalTransforms used in Plone"
HOMEPAGE="http://www.sourceforge.net/projects/archetypes"
SRC_URI="mirror://sourceforge/archetypes/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.3"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=net-zope/cmf-1.4.7"

ZPROD_LIST="MimetypesRegistry"

src_install() {
	zproduct_src_install all
}
