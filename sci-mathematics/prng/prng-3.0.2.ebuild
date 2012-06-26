# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/prng/prng-3.0.2.ebuild,v 1.2 2012/06/26 21:52:15 bicatali Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="Pseudo-Random Number Generator library"
HOMEPAGE="http://statmath.wu.ac.at/prng/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"
LICENSE="GPL-2"

SLOT=0
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"
DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-shared.patch
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && doins doc/${PN}.pdf
	if use examples; then
		emake distclean -C examples
		rm -f examples/Makefile*
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
