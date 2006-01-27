# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.2.5_rc5.ebuild,v 1.4 2006/01/27 02:25:12 vapier Exp $

inherit zproduct

MY_P=Archetypes-1.2.5-rc5
DESCRIPTION="Allows creation of new content types for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="ppc x86"

RDEPEND=">=net-zope/plone-1.0.1
	net-zope/portaltransforms"

S=${WORKDIR}/${MY_P}

ZPROD_LIST="Archetypes ArchExample ArchGenXML generator validation"
