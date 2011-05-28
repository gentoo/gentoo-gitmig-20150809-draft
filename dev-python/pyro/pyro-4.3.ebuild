# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-4.3.ebuild,v 1.5 2011/05/28 12:29:52 ranger Exp $

EAPI="3"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"

inherit distutils

MY_P="Pyro4-${PV}"

DESCRIPTION="Advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://www.xs4all.nl/~irmen/pyro4/ http://www.razorvine.net/python/Pyro http://pypi.python.org/pypi/Pyro4"
SRC_URI="http://www.xs4all.nl/~irmen/pyro4/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="4"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

DEPEND="!dev-python/pyro:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="Pyro4"

src_prepare() {
	distutils_src_prepare

	find -name "._*" -print0 | xargs -0 rm -f

	# Disable tests requiring network connection.
	sed \
		-e "s/testOwnloopBasics/_&/" \
		-e "s/testStartNSfunc/_&/" \
		-i tests/PyroTests/namingtests2.py
	sed -e "s/testServerConnections/_&/" -i tests/PyroTests/servertests.py
	sed \
		-e "s/testBroadcast/_&/" \
		-e "s/testGetIP/_&/" \
		-i tests/PyroTests/sockettests.py
	sed \
		-e "s/testBCstart/_&/" \
		-e "s/testDaemonPyroObj/_&/" \
		-e "s/testLookupAndRegister/_&/" \
		-e "s/testMulti/_&/" \
		-e "s/testRefuseDottedNames/_&/" \
		-e "s/testResolve/_&/" \
		-i tests/PyroTests/namingtests.py
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
		dohtml -r docs/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
