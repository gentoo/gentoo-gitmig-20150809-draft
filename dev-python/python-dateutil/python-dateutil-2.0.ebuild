# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dateutil/python-dateutil-2.0.ebuild,v 1.2 2012/01/19 15:47:51 bicatali Exp $

EAPI="3"

# python eclass bloat
PYTHON_DEPEND="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.*"
PYTHON_MODNAME="dateutil"

inherit distutils

DESCRIPTION="Extensions to the standard Python datetime module"
HOMEPAGE="http://labix.org/python-dateutil http://pypi.python.org/pypi/python-dateutil"
SRC_URI="http://labix.org/download/python-dateutil/${P}.tar.gz"

LICENSE="BSD"
SLOT="python-3"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

RDEPEND="sys-libs/timezone-data"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="NEWS README"

src_prepare() {
	distutils_src_prepare

	# Use zoneinfo in /usr/share/zoneinfo.
	sed -i \
		-e "s/zoneinfo.gettz/gettz/g" \
		test.py || die

	# Fix parsing of date in non-English locales.
	sed -i \
		-e 's/subprocess.getoutput("date")/subprocess.getoutput("LC_ALL=C date")/' \
		example.py || die

	# https://bugs.launchpad.net/dateutil/+bug/892569
	sed -i \
		-e '199s/fileobj = open(fileobj)/fileobj = open(fileobj, "rb")/' \
		dateutil/tz.py || die
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_zoneinfo() {
		rm -f "${ED}"$(python_get_sitedir)/dateutil/zoneinfo/*.tar.* || return 1
	}
	python_execute_function -q delete_zoneinfo

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins example.py sandbox/*.py
	fi
}

