# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Form License v2
# $Header $

inherit zproduct

DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="mirror://sourceforge/plone/CMFPlone${PV}.tar.gz"
S="${WORKDIR}/CMFPlone-${PV}"
LICENSE="GPL-2"
KEYWORDS="~x86"
RDEPEND="=net-zope/cmf-1.3*
	>=net-zope/formulator-1.2.0
	${RDEPEND}"

ZPROD_LIST="CMFPlone DCWorkflow"

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
}

