# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/neoportallibrary/neoportallibrary-0.9b.ebuild,v 1.6 2006/01/27 02:39:25 vapier Exp $

inherit zproduct

P_NEW="NeoPortalLibrary-${PV}"
DESCRIPTION="Collection of modules to build Zope/CMF/Plone products"
HOMEPAGE="http://www.zoper.net/"
SRC_URI="${HOMEPAGE}/Downloads/${P_NEW}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

ZPROD_LIST="NeoPortalLibrary"
MYDOC="doc/Developers_Guide.txt ${MYDOC}"

src_unpack() {
	unpack ${A}
	mv ${S}/${P_NEW} ${S}/NeoPortalLibrary
}
