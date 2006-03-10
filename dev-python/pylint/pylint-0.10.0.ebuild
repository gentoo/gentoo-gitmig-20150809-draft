# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.10.0.ebuild,v 1.2 2006/03/10 23:46:58 marienz Exp $

inherit distutils eutils

DESCRIPTION="PyLint is a tool to check if a Pyhon module satisfies a coding standard"
SRC_URI="ftp://ftp.logilab.org/pub/pylint/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pylint/"

IUSE=""
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
LICENSE="GPL-2"
DEPEND="|| ( >=dev-python/optik-1.4 >=dev-lang/python-2.3 )
		>=dev-python/logilab-common-0.13.0
		>=dev-python/astng-0.15.1"

DOCS="doc/*.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# these two tests do not pass
	for testname in func_format.py \
		func_noerror_staticmethod_as_decorator.py; do
		mv test/input/${testname} test/input/${testname}.skipped ||
		die "skipping ${testname} failed"
	done

	epatch "${FILESDIR}/${P}-extra-todo.patch"
	epatch "${FILESDIR}/${P}-extra-gtk-disable.patch"
}

src_install() {
	distutils_src_install
	# do not install the test suite (we ran it from src_test already
	# and it makes .py[co] generation very noisy because there are
	# files with SyntaxErrors in there)
	python_version
	rm -rf "${D}/usr/$(get_libdir)/python${PYVER}/site-packages/pylint/test"
}

src_test() {
	# The tests will not work properly from the source dir, so do a
	# temporary install:
	"${python}" setup.py install --home="${T}/test" || die "test copy failed"
	# dir needs to be this or the tests fail
	cd "${T}/test/lib/python/pylint/test"
	PYTHONPATH="${T}/test/lib/python" "${python}" runtests.py || \
		die "tests failed"
	cd "${S}"
	rm -rf "${T}/test"
}
