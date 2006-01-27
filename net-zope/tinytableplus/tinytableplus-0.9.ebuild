# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/tinytableplus/tinytableplus-0.9.ebuild,v 1.5 2006/01/27 02:47:46 vapier Exp $

inherit zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="TinyTable (a product designed to manage a small amount of tabular dat) with update capability"
HOMEPAGE="http://www.zope.org/Members/hathawsh/TinyTablePlus"
SRC_URI="${HOMEPAGE}/default/TinyTablePlus-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="x86"

S=${WORKDIR}/lib/python/Products

ZPROD_LIST="TinyTablePlus"
