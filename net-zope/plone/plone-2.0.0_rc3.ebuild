# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-2.0.0_rc3.ebuild,v 1.4 2004/07/24 22:56:26 batlogg Exp $

inherit zproduct
S="${WORKDIR}/CMFPlone-2.0-RC3"

DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/CMFPlone2.0-RC3.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=">=net-zope/cmf-1.4.2
	>=net-zope/btreefolder2-1.0
	>=net-zope/cmfactionicons-0.9
	>=net-zope/cmfformcontroller-1.0_beta5
	>=net-zope/cmfquickinstallertool-1.2.1
	>=net-zope/formulator-1.5.0
	>=net-zope/groupuserfolder-2.0_beta1
	${RDEPEND}"

ZPROD_LIST="CMFPlone"
