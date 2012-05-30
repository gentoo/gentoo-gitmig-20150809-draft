# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-2.1.8.ebuild,v 1.1 2012/05/30 06:37:19 iksaif Exp $

EAPI="4"

PYTHON_DEPEND="*:2.5"
RESTRICT_PYTHON_ABIS="2.4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="https://github.com/ask/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/anyjson-0.3.1
	>=dev-python/amqplib-1.0"
DEPEND="${RDEPEND}
	test? ( dev-python/nose-cover3 dev-python/mock )
	dev-python/setuptools"

# If you want to test all transports you also need to depend on:
# redis, pymongo, couchdb, pika-0.5.2, beanstalkc, kombu-sqlalchemy, django (python2),
# django-kombu (python2), boto, PyYAML-3.09, etc... it's a mess !
# Also check setup.py and requirements/ for jython and pypy specific dependencies

src_prepare() {
	if use test; then
		epatch "${FILESDIR}/${PN}-2.1.1-add-assertIsInstance-with-unittest.patch"
	fi
}

src_test() {
		testing() {
		nosetests --py3where build-${PYTHON_ABI}/lib/kombu/tests
		}
		python_execute_function testing
}
