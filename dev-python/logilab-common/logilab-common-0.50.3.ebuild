# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.50.3.ebuild,v 1.2 2010/06/26 18:21:55 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Useful miscellaneous modules used by Logilab projects"
HOMEPAGE="http://www.logilab.org/projects/common/ http://pypi.python.org/pypi/logilab-common"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

# Tests using dev-python/psycopg are skipped when dev-python/psycopg isn't installed.
DEPEND="test? (
		dev-python/egenix-mx-base
		!dev-python/psycopg[-mxdatetime]
	)"
RDEPEND=""

PYTHON_MODNAME="logilab"
# Extra documentation (html/pdf) needs some love

src_prepare() {
	distutils_src_prepare

	# Disable broken tests.
	sed -e "s/test_moved/_&/" -i test/unittest_deprecation.py
	sed -e "s/test_manpage/_&/" -i test/unittest_configuration.py
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

		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --root="${tpath}" || die "Installation for tests failed with Python ${PYTHON_ABI}"

		# Bug 223079.
		if [[ "${EUID}" -eq 0 ]]; then
			rm test/unittest_fileutils.py || die
		fi

		# pytest picks up the tests relative to the current directory, so cd in. Do
		# not cd in too far though (to logilab/common for example) or some
		# relative/absolute module location tests fail.
		pushd "${spath}" >/dev/null || die
		PYTHONPATH="${spath}" "$(PYTHON)" "${tpath}/usr/bin/pytest" -v || return 1
		popd >/dev/null || die
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	python_generate_wrapper_scripts -E -f -q "${ED}usr/bin/pytest"

	doman doc/pytest.1 || die "doman failed"

	# Don't install tests.
	rm -fr "${ED}"usr/lib*/python*/site-packages/${PN/-//}/test || die "Deletion of tests failed"
}
