# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/prng/prng-3.0.2.ebuild,v 1.6 2012/07/05 16:22:30 ago Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="Pseudo-Random Number Generator library"
HOMEPAGE="http://statmath.wu.ac.at/prng/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"

PATCHES=( "${FILESDIR}"/${P}-shared.patch )

src_install() {
	autotools-utils_src_install
	use doc && doins doc/${PN}.pdf
	if use examples; then
		rm -f examples/Makefile* || die
		doins -r examples
	fi
}
