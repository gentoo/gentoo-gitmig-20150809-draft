 
# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/neoportallibrary/neoportallibrary-0.9b.ebuild,v 1.2 2003/06/23 06:12:55 kutsuya Exp $

inherit zproduct
P_NEW="NeoPortalLibrary-${PV}"

DESCRIPTION="Collection of modules to build Zope/CMF/Plone products."
HOMEPAGE="http://www.zoper.net/"
SRC_URI="${HOMEPAGE}/Downloads/${P_NEW}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

ZPROD_LIST="NeoPortalLibrary"
MYDOC="doc/Developers_Guide.txt ${MYDOC}"

src_unpack()
{
	unpack ${A}
	mv ${S}/${P_NEW} ${S}/NeoPortalLibrary
}
