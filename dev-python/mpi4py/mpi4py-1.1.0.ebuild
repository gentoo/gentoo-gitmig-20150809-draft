# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpi4py/mpi4py-1.1.0.ebuild,v 1.2 2009/08/29 23:02:32 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Message Passing Interface for Python"
HOMEPAGE="http://code.google.com/p/mpi4py/"
SRC_URI="http://mpi4py.googlecode.com/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
IUSE="doc examples"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"

src_test() {
	testing() {
		PYTHONPATH="$(dir -d build-${PYTHON_ABI}/lib*)" mpiexec -n 2 "$(PYTHON)" test/runalltest.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r docs/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r demo/* || die
	fi
}
