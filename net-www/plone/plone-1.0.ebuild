# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Form License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/plone/plone-1.0.ebuild,v 1.1 2003/02/17 05:32:25 kutsuya Exp $

inherit zproduct

DESCRIPTION="A Zope Content Management System, based on Zope CMF."
HOMEPAGE="http://plone.org"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/plone/CMFPlone${PV}.tar.gz"
S="${WORKDIR}/CMFPlone-${PV}"
LICENSE="GPL-2"
KEYWORDS="~x86"
RDEPEND="=net-www/cmf-1.3*
	>=net-www/formulator-1.2.0
	${RDEPEND}"

ZPROD_LIST="CMFPlone DCWorkflow"

# Not sure what to do with folder i18n yet.
# I will study it eventually, but if someone can provide some help...

src_install()
{
	rm -R Formulator/
	zproduct_src_install all
}


