# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libctl/libctl-3.1.ebuild,v 1.7 2012/02/07 13:52:41 ago Exp $

EAPI=4

inherit fortran-2 autotools-utils

DESCRIPTION="Guile-based library for scientific simulations"
HOMEPAGE="http://ab-initio.mit.edu/libctl/"
SRC_URI="http://ab-initio.mit.edu/libctl/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE="doc examples static-libs"

DEPEND="virtual/fortran
	>=dev-scheme/guile-1.6[deprecated]
	sci-libs/nlopt"
RDEPEND="${DEPEND}"

src_install() {
	autotools-utils_src_install
	use doc && dohtml doc/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins "${AUTOTOOLS_BUILD_DIR}"/examples/{*.c,*.h,example.scm,Makefile}
		doins "${S}"/examples/{README,example.c,run.ctl}
	fi
}
