# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfforum/cmfforum-1.0.ebuild,v 1.6 2004/04/05 08:43:26 mr_bones_ Exp $

inherit zproduct

#DESCRIPTION="Makes it easy to install cmf/plone products."
HOMEPAGE="http://www.sf.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFForum-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=net-zope/cmf-1.3
	${RDEPEND}"

ZPROD_LIST="CMFForum"

pkg_postinst()
{
	zproduct_pkg_postinst
	ewarn "Please use CMFQuickInstallerTool or read the documentation of this"
	ewarn "product for instruction on how to add this product to your CMF/Plone site."
}
