# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/mymediamanager/mymediamanager-1.3.1.ebuild,v 1.2 2004/10/17 09:56:01 dholm Exp $

inherit zproduct

DESCRIPTION="Zope product for streaming content management."
HOMEPAGE="http://www.mmmanager.org/"
SRC_URI="http://zope.org/Members/gittew/MyMediaManager/${PV}/MyMediaManager-1.3-1.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=net-zope/zope-2.6.4
		>=net-zope/cmf-1.4.2
		>=net-zope/plone-2.0
	    ${RDEPEND}"
IUSE=""

ZPROD_LIST="MyMediaManager"

pkg_postinst()
{
	zproduct_pkg_postinst
	ewarn "Open ZMI and use CMFQuickInstallerTool or read the documentation of this"
	ewarn "product for instruction on how to add this product to your CMF/Plone site."
}
