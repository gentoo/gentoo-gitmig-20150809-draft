# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.52.0.ebuild,v 1.1 2010/09/29 00:43:05 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Useful miscellaneous modules used by Logilab projects"
HOMEPAGE="http://www.logilab.org/projects/common/ http://pypi.python.org/pypi/logilab-common"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~s390 ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~x64-macos ~x86-macos"
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

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-0.51.1-python-2.7.patch"

	# Disable broken tests.
	sed -e "s/test_knownValues_is_standard_module_4/_&/" -i test/unittest_modutils.py

	# Disable tests failing when stdout is not a tty.
	sed \
		-e "s/test_both_capture/_&/" \
		-e "s/test_capture_core/_&/" \
		-i test/unittest_testlib.py

	if [[ "${EUID}" -eq 0 ]]; then
		# Disable tests failing with root permissions.
		sed \
			-e "s/test_mode_change/_&/" \
			-e "s/test_mode_change_on_append/_&/" \
			-e "s/test_restore_on_close/_&/" \
			-i test/unittest_fileutils.py
	fi
}

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
