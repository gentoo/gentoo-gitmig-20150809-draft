# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyenchant/pyenchant-1.6.1.ebuild,v 1.3 2010/04/22 12:17:31 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Python wrapper for the Enchant spellchecking wrapper library"
HOMEPAGE="http://pyenchant.sourceforge.net http://pypi.python.org/pypi/pyenchant"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=app-text/enchant-1.4.0
	dev-python/setuptools"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="enchant"
DOCS="README.txt TODO.txt"

src_prepare() {
	distutils_src_prepare

	# TestInstallEnv tests are broken with Python 3 (enchant.tokenize is wrongly imported as tokenize).
	sed -e "s/test_basic/_&/;s/test_UnicodeInstallPath/_&/" -i enchant/tests.py || die "sed failed"
}
