# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/tinytableplus/tinytableplus-0.9-r1.ebuild,v 1.3 2008/07/21 20:39:05 tupone Exp $

inherit eutils zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="TinyTable (a product designed to manage a small amount of tabular dat) with update capability"
HOMEPAGE="http://www.zope.org/Members/hathawsh/TinyTablePlus"
SRC_URI="${HOMEPAGE}/default/TinyTablePlus-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~sparc x86"

S=${WORKDIR}/lib/python/Products

ZPROD_LIST="TinyTablePlus"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-zope-2.9.8.patch
}
