# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygsl/pygsl-0.9.5.ebuild,v 1.2 2010/06/24 21:03:06 pacho Exp $

EAPI=2
SUPPORT_PYTHON_ABIS="1"
inherit distutils

DESCRIPTION="A Python interface for the GNU scientific library (gsl)."
HOMEPAGE="http://pygsl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

DEPEND="sci-libs/gsl
	dev-python/numpy"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		cd "${S}/tests"
		PYTHONPATH=$(ls -d ../build-${PYTHON_ABI}/lib*) "$(PYTHON)" run_test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "install examples failed"
	fi
}
