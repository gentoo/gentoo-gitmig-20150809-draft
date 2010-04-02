# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cython/cython-0.12.1.ebuild,v 1.4 2010/04/02 15:38:24 jer Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Cython"
MY_P="${MY_PN}-${PV/_/.}"

DESCRIPTION="A language for writing Python extension modules based on pyrex"
HOMEPAGE="http://www.cython.org/ http://pypi.python.org/pypi/Cython"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	http://www.cython.org/release/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN} pyximport"
DOCS="ToDo.txt USAGE.txt"

src_test() {
	testing() {
		# Tests fail with Python 3 due to bug in Python.
		# http://bugs.python.org/issue7173
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		rm -fr BUILD
		# Tests sometimes hang with forking enabled.
		"$(PYTHON)" runtests.py --no-fork -vv
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# '-A c' is for ignoring of Doc/primes.c.
	use doc && dohtml -A c -r Doc/*

	if use examples; then
		# Demos/ has files with .so,~ suffixes.
		# So we have to specify precisely what to install.
		insinto /usr/share/doc/${PF}/examples
		doins Demos/Makefile* Demos/setup.py Demos/*.{py,pyx}
	fi
}
