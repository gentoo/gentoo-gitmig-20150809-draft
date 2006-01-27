# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfquickinstallertool/cmfquickinstallertool-1.5.0.ebuild,v 1.5 2006/01/27 02:30:30 vapier Exp $

inherit zproduct

DESCRIPTION="Makes it easy to install cmf/plone products"
HOMEPAGE="http://www.sf.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFQuickInstallerTool-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"

RDEPEND=">=net-zope/cmf-1.3"

ZPROD_LIST="CMFQuickInstallerTool"
