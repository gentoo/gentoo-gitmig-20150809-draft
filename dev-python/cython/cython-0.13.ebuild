# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cython/cython-0.13.ebuild,v 1.5 2010/10/22 03:58:43 jer Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Cython"
MY_P="${MY_PN}-${PV/_/.}"

DESCRIPTION="The Cython compiler for writing C extensions for the Python language"
HOMEPAGE="http://www.cython.org/ http://pypi.python.org/pypi/Cython"
SRC_URI="mirror://pypi/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	http://www.cython.org/release/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="ToDo.txt USAGE.txt"
PYTHON_MODNAME="Cython pyximport"

src_test() {
	testing() {
		rm -fr BUILD
		"$(PYTHON)" runtests.py -vv
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		# "-A c" is for ignoring of "Doc/primes.c".
		dohtml -A c -r Doc/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Demos/* || die "Installation of examples failed"
	fi
}
