# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Form License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone/plone-1.0.3.ebuild,v 1.1 2003/06/21 07:51:54 kutsuya Exp $

inherit zproduct
S="${WORKDIR}/CMFPlone-${PV}"

DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/CMFPlone${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
RDEPEND="=net-zope/cmf-1.3.1*
	>=net-zope/formulator-1.2.0
	${RDEPEND}"

ZPROD_LIST="CMFPlone DCWorkflow"
MYDOC="docs/NavigationTool.txt docs/SiteTypes.txt ${MYDOC}"

src_install()
{
	rm -R Formulator/
	zproduct_src_install all
}

# Since i18n isn't a product folder, leaving it in $ZP_DIR/$PF.

pkg_postinst()
{
	zproduct_pkg_postinst
	einfo "---> NOTE: i18n folder location: ${ZP_DIR}/${PF}"
    ewarn "Using >net-zope/cmf-1.3.1 will break this product."
}

