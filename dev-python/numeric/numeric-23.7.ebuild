# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-23.7.ebuild,v 1.15 2005/08/22 22:34:17 lucass Exp $

inherit distutils eutils

MY_P=${P/n/N}
S=${WORKDIR}/${MY_P}

DESCRIPTION="a fast, compact, multidimensional array language facility"
HOMEPAGE="http://numeric.scipy.org/"
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

# 2.1 gave sandbox violations see #21
DEPEND=">=dev-lang/python-2.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.patch
}

src_install() {
	distutils_src_install
	distutils_python_version

	#Numerical Tutorial is nice for testing and learning
	insinto /usr/lib/python${PYVER}/site-packages/NumTut
	doins Demo/NumTut/*
}
