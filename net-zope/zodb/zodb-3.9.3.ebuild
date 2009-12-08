# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.9.3.ebuild,v 1.3 2009/12/08 12:32:14 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="ZODB3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Object DataBase"
HOMEPAGE="http://pypi.python.org/pypi/ZODB3 http://zope.org/Products/ZODB3 http://wiki.zope.org/ZODB/FrontPage https://launchpad.net/zodb"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-zope/transaction
	net-zope/zc-lockfile
	net-zope/zconfig
	net-zope/zdaemon
	net-zope/zope-event
	net-zope/zope-interface
	net-zope/zope-proxy
	net-zope/zope-testing"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="BTrees persistent ZEO ZODB"
DOCS="doc/* HISTORY.txt README.txt"

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r 2 src
	epatch "${FILESDIR}/${P}-py24compat.h.patch"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Don't install sources.
	find "${D}"usr/$(get_libdir)/python*/site-packages -name "*.c" -o -name "*.h" | xargs rm -f
}
