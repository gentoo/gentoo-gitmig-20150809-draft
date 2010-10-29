# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/weberror/weberror-0.10.2.ebuild,v 1.2 2010/10/29 19:53:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="WebError"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web Error handling and exception catching"
HOMEPAGE="http://pypi.python.org/pypi/WebError"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/paste-1.7.1
	dev-python/pygments
	dev-python/setuptools
	dev-python/simplejson
	dev-python/tempita
	dev-python/webob"
DEPEND="${RDEPEND}
	test? ( dev-python/webtest )"

S="${WORKDIR}/${MY_P}"
