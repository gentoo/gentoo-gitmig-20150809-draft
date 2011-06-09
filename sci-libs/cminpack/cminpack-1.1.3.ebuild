# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cminpack/cminpack-1.1.3.ebuild,v 1.1 2011/06/09 20:52:31 bicatali Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="C implementation of the MINPACK nonlinear optimization library"
HOMEPAGE="http://devernay.free.fr/hacks/cminpack/cminpack.html"
SRC_URI="http://devernay.free.fr/hacks/cminpack/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

src_configure() {
	mycmakeargs+=(
		-DSHARED_LIBS=ON
		$(cmake-utils_use_build test examples)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc readme*
	use doc && dohtml -A .txt doc/*
}
