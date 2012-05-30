# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celery/celery-2.5.3.ebuild,v 1.1 2012/05/30 06:45:54 iksaif Exp $

EAPI="4"

# Note: some tests are still broken for python3...
# PYTHON_TESTS_RESTRICTED_ABIS="3.*"
PYTHON_DEPEND="*:2.7"
RESTRICT_PYTHON_ABIS="2.[4-6]"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="Celery is an open source asynchronous task queue/job queue based on distributed message passing."
HOMEPAGE="http://celeryproject.org/ http://pypi.python.org/pypi/celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sql test"

# jython would need: threadpool, simplejson
# python2.5 would need: ordereddict, test? unittest2
# python2.6 would need: multiprocessing, test? simplejson
RDEPEND=">=dev-python/kombu-2.1.1
	<dev-python/kombu-3.0
	sql? ( dev-python/sqlalchemy )
	dev-python/python-dateutil
	>=dev-python/anyjson-0.3.1
	dev-python/pyparsing
	"
DEPEND="${RDEPEND}
	test? (
		  >=dev-python/mock-0.7.0
		  dev-python/pyopenssl
		  dev-python/nose-cover3
		  dev-python/sqlalchemy
		  dev-python/pymongo
		  dev-python/cl
		  dev-db/redis
	)
	dev-python/setuptools"

src_test() {
		testing() {
		nosetests --py3where build-${PYTHON_ABI}/lib/celery/tests
		}
		python_execute_function testing
}

src_install() {

	distutils_src_install --install-scripts="/usr/bin"

	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd" celery
	newconfd "${FILESDIR}/celery.confd" celery
}
