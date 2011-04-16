# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-4.1.ebuild,v 1.5 2011/04/16 18:37:57 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"

inherit distutils

MY_P="Pyro-${PV}"

DESCRIPTION="Advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://www.xs4all.nl/~irmen/pyro4/ http://pypi.python.org/pypi/Pyro"
SRC_URI="http://www.xs4all.nl/~irmen/pyro4/download/${MY_P}-python3.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}-python3"

PYTHON_MODNAME="Pyro"

src_prepare() {
	distutils_src_prepare

	# PyroTests.namingtests.NameServerTests.testResolve sometimes hangs.
	sed -e "s/testResolve/_&/" -i tests/PyroTests/namingtests.py || die "sed failed"
}

src_test() {
	cd tests

	testing() {
		"$(PYTHON)" run_testsuite.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
