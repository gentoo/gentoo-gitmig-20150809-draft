# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfcollectorng/cmfcollectorng-0.20.ebuild,v 1.1 2003/03/09 04:06:12 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope/CMF-based bugtracking system."
HOMEPAGE="http://www.zope.org/Members/ajung/CMFCollectorNG/Wiki/FrontPage"
SRC_URI="mirror://sourceforge/cmfcollectorng/CMFCollectorNG-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86"
RDEPEND=">=net-zope/cmf-1.3
	${RDEPEND}"
ZPROD_LIST="CMFCollectorNG"

