# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-2.3.0.ebuild,v 1.1 2012/07/29 20:17:27 iksaif Exp $

EAPI="4"

PYTHON_DEPEND="*:2.5"
RESTRICT_PYTHON_ABIS="2.4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://pypi.python.org/pypi/kombu https://github.com/ask/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/anyjson-0.3.3
	>=dev-python/amqplib-1.0"
DEPEND="${RDEPEND}
	test? ( dev-python/nose-cover3
	dev-python/mock
	dev-python/simplejson
	dev-python/anyjson
	dev-python/redis-py
	dev-python/pymongo
	dev-python/msgpack )
	doc? ( dev-python/sphinx
	dev-python/beanstalkc
	dev-python/couchdb-python )
	dev-python/setuptools"

src_prepare() {
	if use test; then
		epatch "${FILESDIR}/${PN}-2.1.1-add-assertIsInstance-with-unittest.patch"
	fi
}

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	testing() {
		nosetests --py3where build-${PYTHON_ABI}/lib/${PN}/tests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		docompress -x usr/share/doc/${P}/examples/
		insinto usr/share/doc/${P}/
		doins -r examples/
	fi
	use doc && dohtml -r docs/.build/html/
}
