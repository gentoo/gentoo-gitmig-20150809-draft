# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/tinytableplus/tinytableplus-0.9.ebuild,v 1.1 2004/02/09 13:32:01 lanius Exp $ 

inherit zproduct
NEW_PV="${PV//./-}"

DESCRIPTION="TinyTable (a product designed to manage a small amount of tabular dat) with update capability"
HOMEPAGE="http://www.zope.org/Members/hathawsh/TinyTablePlus"
SRC_URI="${HOMEPAGE}/default/TinyTablePlus-${PV}.tgz"
S=${WORKDIR}/lib/python/Products
LICENSE="ZPL"
KEYWORDS="~x86"

ZPROD_LIST="TinyTablePlus"
