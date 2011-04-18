# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beaker/beaker-1.5.4-r1.ebuild,v 1.1 2011/04/18 23:15:48 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
#PYTHON_TESTS_RESTRICTED_ABIS="3.*"
#DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Beaker"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Session and Caching library with WSGI Middleware"
HOMEPAGE="http://beaker.groovie.org/ http://pypi.python.org/pypi/Beaker"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/nose dev-python/webtest )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Workaround for http://bugs.python.org/issue11276.
	sed -e "s/import anydbm/& as anydbm/" -i beaker/container.py
}

src_test() {
	testing() {
		[[ "${PYTHON_ABI}" == 3.* ]] && return
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests
	}
	python_execute_function testing
}
