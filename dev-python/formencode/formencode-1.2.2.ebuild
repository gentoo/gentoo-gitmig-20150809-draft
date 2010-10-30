# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/formencode/formencode-1.2.2.ebuild,v 1.7 2010/10/30 20:44:31 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="FormEncode"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML form validation, generation and conversion package."
HOMEPAGE="http://formencode.org/ http://pypi.python.org/pypi/FormEncode"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Avoid test failure when dev-python/formencode isn't already installed.
	sed -e "/pkg_resources/d" -i tests/__init__.py
}

src_test() {
	LC_ALL="C" distutils_src_test
}

src_install() {
	distutils_src_install

	if use doc; then
		cd "${S}"
		dodoc docs/*.txt

		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
