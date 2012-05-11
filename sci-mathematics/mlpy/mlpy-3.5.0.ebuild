# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mlpy/mlpy-3.5.0.ebuild,v 1.1 2012/05/11 16:11:40 dberkholz Exp $

EAPI=4

inherit distutils

DESCRIPTION="Machine Learning PYthon (mlpy) is a high-performance Python library for predictive modeling"
HOMEPAGE="https://mlpy.fbk.eu/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
RDEPEND=">=sci-libs/gsl-1.11
	>=dev-python/numpy-1.3
	>=sci-libs/scipy-0.7
	>=dev-lang/python-2.6"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

src_install() {
	distutils_src_install
	if use doc; then
		pushd docs 2>/dev/null || die
		emake html || die
		dohtml -r build/html/*
		popd 2>/dev/null || die
	fi
}
