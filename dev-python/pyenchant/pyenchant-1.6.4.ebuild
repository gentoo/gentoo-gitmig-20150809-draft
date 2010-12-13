# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyenchant/pyenchant-1.6.4.ebuild,v 1.1 2010/12/13 20:16:52 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Python bindings for the Enchant spellchecking system"
HOMEPAGE="http://pyenchant.sourceforge.net http://pypi.python.org/pypi/pyenchant"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=app-text/enchant-${PV%.*}
	dev-python/setuptools"
RDEPEND="${DEPEND}"

DOCS="README.txt TODO.txt"
PYTHON_MODNAME="enchant"

src_prepare() {
	distutils_src_prepare

	# Fix compatibility with Python 3.
	sed -e "s/for i in xrange/for i in range/" -i enchant/__init__.py || die "sed failed"

	# TestInstallEnv tests are broken with Python 3 (enchant.tokenize is wrongly imported as tokenize).
	sed -e "s/test_basic/_&/;s/test_UnicodeInstallPath/_&/" -i enchant/tests.py || die "sed failed"
}

src_test() {
	if [[ -n "$(LC_ALL="en_US.UTF-8" bash -c "" 2>&1)" ]]; then
		ewarn "Disabling tests due to missing en_US.UTF-8 locale"
	else
		distutils_src_test
	fi
}
