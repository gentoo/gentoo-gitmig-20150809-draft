# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfformcontroller/cmfformcontroller-1.0.1.ebuild,v 1.1 2004/03/26 22:56:27 batlogg Exp $

inherit zproduct

DESCRIPTION="CMFFormController replaces the portal_form form validation mechanism from Plone."
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/CMFFormController-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
SLOT="0"

RDEPEND="${RDEPEND}
	net-zope/cmf"

ZPROD_LIST="CMFFormController"
