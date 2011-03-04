# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/redis-py/redis-py-2.2.2.ebuild,v 1.1 2011/03/04 17:39:49 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python client for Redis key-value store"
HOMEPAGE="http://github.com/andymccurdy/redis-py http://pypi.python.org/pypi/redis"
SRC_URI="http://cloud.github.com/downloads/andymccurdy/redis-py/redis-2.2.2.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/redis-${PV}"

DOCS="README.md CHANGES"

#src_test() { redis-py doesn't like being tested
#	testing() {
#		"$(PYTHON)" setup.py test
#	}
#	python_execute_function testing
#}
