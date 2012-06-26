# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/unuran/unuran-1.8.1.ebuild,v 1.2 2012/06/26 21:19:33 bicatali Exp $

EAPI=4
inherit eutils

DESCRIPTION="Universal Non-Uniform Random number generator"
HOMEPAGE="http://statmath.wu.ac.at/unuran/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"
LICENSE="GPL-2"

SLOT=0
KEYWORDS="~amd64 ~x86 ~amd64 ~x86-linux"
IUSE="doc examples gsl prng +rngstreams static-libs"
DEPEND="gsl? ( sci-libs/gsl )
	prng? ( sci-mathematics/prng )
	rngstreams? ( sci-mathematics/rngstreams )"
RDEPEND="${DEPEND}"

src_configure() {
	local udefault=builtin
	use rngstreams && udefault=rngstream
	econf \
		--enable-shared \
		--with-urng-default=${udefault} \
		$(use_enable static-libs static) \
		$(use_with gsl urng-gsl) \
		$(use_with prng urng-prng) \
		$(use_with rngstreams urng-rngstream)
}

src_install() {
	default
	use doc && dodoc doc/${PN}.pdf
	if use examples; then
		emake distclean -C examples
		rm -f examples/Makefile*
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
