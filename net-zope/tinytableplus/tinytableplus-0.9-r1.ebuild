# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/tinytableplus/tinytableplus-0.9-r1.ebuild,v 1.1 2005/05/08 02:56:13 nerdboy Exp $

inherit zproduct
NEW_PV="${PV//./-}"

DESCRIPTION="TinyTable (a product designed to manage a small amount of tabular dat) with update capability"
HOMEPAGE="http://www.zope.org/Members/hathawsh/TinyTablePlus"
SRC_URI="${HOMEPAGE}/default/TinyTablePlus-${PV}.tgz"
S=${WORKDIR}/lib/python/Products
LICENSE="ZPL"
KEYWORDS="x86 ~sparc"
IUSE=""

ZPROD_LIST="TinyTablePlus"
