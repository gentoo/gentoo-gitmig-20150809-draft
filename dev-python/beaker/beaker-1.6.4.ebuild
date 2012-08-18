# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beaker/beaker-1.6.4.ebuild,v 1.3 2012/08/18 22:30:53 johu Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Beaker"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Session and Caching library with WSGI Middleware"
HOMEPAGE="http://beaker.groovie.org/ http://pypi.python.org/pypi/Beaker"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/webtest )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Workaround for http://bugs.python.org/issue11276.
	sed -e "s/import anydbm/& as anydbm/;/import anydbm/a dbm = anydbm" -i beaker/container.py
}
