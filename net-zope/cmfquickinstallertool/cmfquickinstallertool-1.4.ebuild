# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfquickinstallertool/cmfquickinstallertool-1.4.ebuild,v 1.3 2004/06/25 01:19:29 agriffis Exp $

inherit zproduct

DESCRIPTION="Makes it easy to install cmf/plone products."
HOMEPAGE="http://www.sf.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFQuickInstallerTool_${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=net-zope/cmf-1.3
	${RDEPEND}"

ZPROD_LIST="CMFQuickInstallerTool"
