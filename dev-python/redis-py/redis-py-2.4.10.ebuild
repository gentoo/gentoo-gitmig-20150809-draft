# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/redis-py/redis-py-2.4.10.ebuild,v 1.1 2011/11/30 16:34:57 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
# Tests are not distributed in the tarball.
# DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Python client for Redis key-value store"
HOMEPAGE="http://github.com/andymccurdy/redis-py http://pypi.python.org/pypi/redis"
SRC_URI="mirror://github/andymccurdy/${PN}/redis-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/redis-${PV}"

DOCS="README.md CHANGES"
PYTHON_MODNAME="redis"
