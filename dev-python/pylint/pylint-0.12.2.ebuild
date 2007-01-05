# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.12.2.ebuild,v 1.2 2007/01/05 19:16:13 lucass Exp $

inherit distutils eutils

DESCRIPTION="PyLint is a tool to check if a Python module satisfies a coding standard"
SRC_URI="ftp://ftp.logilab.org/pub/pylint/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pylint/"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
DEPEND="|| ( >=dev-python/optik-1.4 >=dev-lang/python-2.3 )
		>=dev-python/logilab-common-0.21.0
		>=dev-python/astng-0.16.0"

DOCS="doc/*.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make the test that tries to import gtk a bit less strict
	epatch "${FILESDIR}/${PN}-0.10.0-extra-gtk-disable.patch"

	# Make pylint-gui print a gentoo-specific message if Tkinter is missing
	epatch "${FILESDIR}/${PN}-0.11.0-gui-no-tkinter.patch"
}

src_install() {
	distutils_src_install
	# do not install the test suite (we ran it from src_test already
	# and it makes .py[co] generation very noisy because there are
	# files with SyntaxErrors in there)
	python_version
	rm -rf "${D}"/usr/lib*/python${PYVER}/site-packages/pylint/test

	doman man/pylint.1
	dohtml doc/*.html
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

pkg_postinst() {
	distutils_pkg_postinst
	einfo 'A couple of important configuration settings (like "disable-msg")'
	einfo 'moved from the "MASTER" to "MESSAGES CONTROL" section.'
	einfo 'See "pylint --help".'
}
