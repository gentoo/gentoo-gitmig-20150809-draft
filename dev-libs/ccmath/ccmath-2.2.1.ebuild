# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ccmath/ccmath-2.2.1.ebuild,v 1.6 2004/03/14 12:28:57 mr_bones_ Exp $

DESCRIPTION="CCMATH is a mathematics library, coded in C, that contains functions for linear algebra, numerical integration,
	geometry and trigonometry, curve fitting, roots and optimization, Fourier analysis, simulation generation, statistics,
	special functions, sorts and searches, time series models, complex arithmetic, and high precision computations."

SRC_URI="http://www.ibiblio.org/pub/Linux/libs/${P}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/ccmath/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

IUSE=""

src_compile() {
	yes | ./makelibs.sh
}

src_install() {
	dolib.so tmp/libccm.so
	dolib.a tmp/libccm.a
	insinto /usr/include
	doins ccmath.h
	dodoc CHANGES INSTALL README manual/*
}
