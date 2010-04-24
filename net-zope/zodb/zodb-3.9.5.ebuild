# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zodb/zodb-3.9.5.ebuild,v 1.1 2010/04/24 16:46:56 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="ZODB3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Object DataBase"
HOMEPAGE="http://pypi.python.org/pypi/ZODB3 http://zope.org/Products/ZODB3 http://wiki.zope.org/ZODB/FrontPage https://launchpad.net/zodb"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="net-zope/transaction
	net-zope/zc-lockfile
	net-zope/zconfig
	net-zope/zdaemon
	net-zope/zope-event
	net-zope/zope-interface
	net-zope/zope-proxy
	!media-libs/FusionSound"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( net-zope/zope-testing )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="BTrees persistent ZEO ZODB"
DOCS="doc/* HISTORY.txt README.txt"

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r 2 src
}

src_install() {
	distutils_src_install
	python_clean_sitedirs
}
