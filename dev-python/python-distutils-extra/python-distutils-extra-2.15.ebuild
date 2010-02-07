# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-distutils-extra/python-distutils-extra-2.15.ebuild,v 1.1 2010/02/07 02:42:39 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="You can integrate gettext support, themed icons and scrollkeeper based documentation in distutils."
HOMEPAGE="https://launchpad.net/python-distutils-extra"
SRC_URI="http://launchpad.net/python-distutils-extra/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"
# Tests are broken.
RESTRICT="test"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="DistUtilsExtra"
DOCS="doc/FAQ doc/README doc/setup.cfg.example doc/setup.py.example"

src_prepare() {
	# Disable broken tests.
	sed \
		-e "s/test_desktop/_&/" \
		-e "s/test_policykit/_&/" \
		-e "s/test_requires_provides/_&/" \
		-i test/auto.py || die "sed failed"
}

src_test() {
	# 4 tests fail with disabled byte-compilation.
	python_enable_pyc

	testing() {
		"$(PYTHON)" test/auto.py
	}
	python_execute_function testing

	python_disable_pyc
}
