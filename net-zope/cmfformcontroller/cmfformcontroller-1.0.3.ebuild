# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfformcontroller/cmfformcontroller-1.0.3.ebuild,v 1.4 2005/04/02 08:52:31 blubb Exp $

inherit zproduct

DESCRIPTION="CMFFormController replaces the portal_form form validation mechanism from Plone."
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/CMFFormController-${PV}-beta.tar.gz"
LICENSE="ZPL"
KEYWORDS="x86 ppc ~sparc ~amd64"

RDEPEND="${RDEPEND}
	net-zope/cmf"

ZPROD_LIST="CMFFormController"
