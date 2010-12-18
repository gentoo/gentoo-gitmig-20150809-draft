# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paisley/paisley-0.1.ebuild,v 1.8 2010/12/18 19:26:35 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Paisley is a CouchDB client written in Python to be used within a Twisted application."
HOMEPAGE="http://launchpad.net/paisley"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-python/simplejson
	dev-python/twisted
	dev-python/twisted-web"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="paisley.py"

src_test() {
	distutils_src_test test_paisley.py
}
