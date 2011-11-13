# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/4ti2/4ti2-1.3.2-r1.ebuild,v 1.2 2011/11/13 19:30:50 vapier Exp $

EAPI=4

inherit autotools autotools-utils

DESCRIPTION="Software package for algebraic, geometric and combinatorial problems"
HOMEPAGE="http://www.4ti2.de/"
SRC_URI="http://4ti2.de/version_${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="
	sci-mathematics/glpk[gmp]
	|| ( dev-libs/gmp[cxx] dev-libs/gmp[-nocxx] )"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

PATCHES=( "${FILESDIR}"/${P}-gold.patch )

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}
