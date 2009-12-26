# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.45.1.ebuild,v 1.5 2009/12/26 16:17:10 armin76 Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils python

DESCRIPTION="Useful miscellaneous modules used by Logilab projects"
HOMEPAGE="http://www.logilab.org/projects/common/"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 s390 sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE="test"

DEPEND="test? ( dev-python/egenix-mx-base )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="logilab"
# Extra documentation (html/pdf) needs some love

pkg_setup() {
	# Tests using dev-python/psycopg are skipped when dev-python/psycopg isn't installed.
	if use test && has_version dev-python/psycopg && ! has_version dev-python/psycopg[mxdatetime]; then
		die "dev-python/psycopg should be installed with USE=\"mxdatetime\""
	fi
}

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-0.41.0-remove-broken-tests.patch"
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
	[[ -z "${ED}" ]] && local ED="${D}"
	distutils_src_install

	doman doc/pytest.1 || die "doman failed"

	# Remove unittests since they're just needed during build-time
	rm -fr "${ED}"usr/lib*/python*/site-packages/${PN/-//}/test || die
}
