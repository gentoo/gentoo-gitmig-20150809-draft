# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfformcontroller/cmfformcontroller-1.0.3.ebuild,v 1.2 2004/09/24 20:55:17 batlogg Exp $

inherit zproduct

DESCRIPTION="CMFFormController replaces the portal_form form validation mechanism from Plone."
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/CMFFormController-${PV}-beta.tar.gz"
LICENSE="ZPL"
KEYWORDS="x86 ppc"

RDEPEND="${RDEPEND}
	net-zope/cmf"

ZPROD_LIST="CMFFormController"
