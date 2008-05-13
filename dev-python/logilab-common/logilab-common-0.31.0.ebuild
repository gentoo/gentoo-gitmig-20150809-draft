# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.31.0.ebuild,v 1.1 2008/05/13 12:33:49 hawking Exp $

inherit distutils eutils

DESCRIPTION="Several modules providing low level functionality shared among some python projects developed by logilab."
HOMEPAGE="http://www.logilab.org/projects/common/"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="test"

DEPEND="|| ( >=dev-python/optik-1.4 >=dev-lang/python-2.3 )
	test? ( dev-python/egenix-mx-base )"

PYTHON_MODNAME="logilab"

src_test() {
	# Install temporarily.
	local spath="test/lib/python"
	"${python}" setup.py install --home="${T}/test" || die "test copy failed"

	# It picks up the tests relative to the current dir, so cd in. Do
	# not cd in too far though (to logilab/common for example) or some
	# relative/absolute module location tests fail.
	pushd "${T}/${spath}" >/dev/null

	# Remove a botched doctest.
	pushd logilab/common >/dev/null
	epatch "${FILESDIR}/${P}-remove-broken-tests.patch"
	popd >/dev/null

	# HACK: tell it to exit nonzero if the tests fail.
	sed -i -e 's/exitafter=False/exitafter=True/' "${T}/test/bin/pytest" \
		|| die "sed failed"

	# These tests will fail:
	if ! has userpriv ${FEATURES}; then
		rm "${S}"/test/unittest_fileutils.py
	fi

	PYTHONPATH="${T}/${spath}" "${python}" \
		"${T}/test/bin/pytest" -v || die "tests failed"
	popd >/dev/null
}
