# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfcollectorng/cmfcollectorng-0.20.ebuild,v 1.2 2003/04/04 03:49:38 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope/CMF-based bugtracking system."
HOMEPAGE="http://www.zope.org/Members/ajung/CMFCollectorNG/Wiki/FrontPage"
SRC_URI="mirror://sourceforge/cmfcollectorng/CMFCollectorNG-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=net-zope/cmf-1.3
	${RDEPEND}"

ZPROD_LIST="CMFCollectorNG"

pkg_postinst()
{
	zproduct_pkg_postinst
	ewarn "Please read INSTALL.txt.gz for this product to understand how to"
    ewarn "'add' this product into a CMF site. (i.e. external method)"
}

