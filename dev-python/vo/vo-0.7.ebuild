# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vo/vo-0.7.ebuild,v 1.2 2011/08/04 00:04:14 bicatali Exp $

EAPI=3

PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"

inherit distutils eutils

DESCRIPTION="Python module to read VOTABLE into a Numpy recarray"
HOMEPAGE="https://trac6.assembla.com/astrolib/wiki http://www.scipy.org/AstroLib"
SRC_URI="http://stsdas.stsci.edu/astrolib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6-expat.patch
}

src_test() {
	cd test
	testing() {
		PYTHONPATH="$(ls -d ${S}/build-${PYTHON_ABI}/lib*)"  \
			"$(PYTHON)" benchmarks.py || die "test failed with Python ${PYTHON_ABI}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples || die
	fi
}
