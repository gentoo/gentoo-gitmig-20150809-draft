# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfformcontroller/cmfformcontroller-1.0_rc1.ebuild,v 1.4 2004/06/25 01:18:29 agriffis Exp $

inherit zproduct

MY_P=1_0_RC1

DESCRIPTION="CMFFormController replaces the portal_form form validation mechanism from Plone."
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/CMFFormController.${MY_P}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
SLOT="0"

RDEPEND="${RDEPEND}
	net-zope/cmf"

ZPROD_LIST="CMFFormController"
