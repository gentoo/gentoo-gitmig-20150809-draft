# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfformcontroller/cmfformcontroller-1.0.2.ebuild,v 1.2 2006/01/27 02:28:06 vapier Exp $

inherit zproduct

DESCRIPTION="CMFFormController replaces the portal_form form validation mechanism from Plone"
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/CMFFormController-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

RDEPEND="net-zope/cmf"

ZPROD_LIST="CMFFormController"
