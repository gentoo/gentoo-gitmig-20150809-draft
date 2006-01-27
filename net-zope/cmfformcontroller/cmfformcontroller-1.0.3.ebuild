# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfformcontroller/cmfformcontroller-1.0.3.ebuild,v 1.5 2006/01/27 02:28:06 vapier Exp $

inherit zproduct

DESCRIPTION="CMFFormController replaces the portal_form form validation mechanism from Plone"
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/CMFFormController-${PV}-beta.tar.gz"

LICENSE="ZPL"
KEYWORDS="~amd64 ppc ~sparc x86"

RDEPEND="net-zope/cmf"

ZPROD_LIST="CMFFormController"
