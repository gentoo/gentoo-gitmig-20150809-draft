# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/archetypes/archetypes-1.2.5_rc4.ebuild,v 1.4 2004/07/27 18:56:48 batlogg Exp $

inherit zproduct

MY_P=${PN}-1.2.5-rc4

DESCRIPTION="Allows creation of new content types for Plone"
HOMEPAGE="http://www.sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
S=${WORKDIR}/${MY_P}
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=net-zope/plone-1.0.1
		net-zope/portaltransforms
		${RDEPEND}"

ZPROD_LIST="Archetypes ArchExample ArchGenXML generator validation"
