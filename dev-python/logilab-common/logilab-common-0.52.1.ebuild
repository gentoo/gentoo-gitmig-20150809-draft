# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.52.1.ebuild,v 1.6 2010/12/07 11:46:37 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Useful miscellaneous modules used by Logilab projects"
HOMEPAGE="http://www.logilab.org/projects/common/ http://pypi.python.org/pypi/logilab-common"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-python/setuptools"
# Tests using dev-python/psycopg are skipped when dev-python/psycopg isn't installed.
# dev-python/unittest2 is not required with Python >=3.2.
DEPEND="${RDEPEND}
	test? (
		dev-python/egenix-mx-base
		dev-python/unittest2
		!dev-python/psycopg[-mxdatetime]
	)"

PYTHON_MODNAME="logilab"

src_test() {
	testing() {
		# Install temporarily.
		local tpath="${T}/test-${PYTHON_ABI}"
		local spath="${tpath}$(python_get_sitedir)"

		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --root="${tpath}" || die "Installation for tests failed with $(python_get_implementation) $(python_get_version)"

		# pytest uses tests placed relatively to the current directory.
		pushd "${spath}" > /dev/null || return 1
		PYTHONPATH="${spath}" "$(PYTHON)" "${tpath}/usr/bin/pytest" -v || return 1
		popd > /dev/null || return 1
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	python_generate_wrapper_scripts -E -f -q "${ED}usr/bin/pytest"

	doman doc/pytest.1 || die "doman failed"

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/${PN/-//}/test"
	}
	python_execute_function -q delete_tests
}
