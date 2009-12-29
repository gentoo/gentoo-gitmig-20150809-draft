# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webhelpers/webhelpers-0.6.4.ebuild,v 1.4 2009/12/29 21:37:44 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="WebHelpers"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A library of helper functions intended to make writing templates in web applications easier."
HOMEPAGE="http://pylonshq.com/docs/en/0.9.7/thirdparty/webhelpers/ http://pypi.python.org/pypi/WebHelpers"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-python/routes-1.8"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose dev-python/coverage )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}
