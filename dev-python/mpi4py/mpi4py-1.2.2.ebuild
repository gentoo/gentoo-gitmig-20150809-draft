# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpi4py/mpi4py-1.2.2.ebuild,v 1.3 2012/02/23 09:52:20 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Message Passing Interface for Python"
HOMEPAGE="http://code.google.com/p/mpi4py/ http://pypi.python.org/pypi/mpi4py"
SRC_URI="http://mpi4py.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" mpiexec -n 2 "$(PYTHON)" test/runalltest.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r docs/* || die "doins failed"
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r demo/* || die "doins failed"
	fi
}
