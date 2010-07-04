# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.4.6.ebuild,v 1.1 2010/07/04 01:34:28 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
# winpdb has (at least partial) support for Python 3, but wxpython does not yet support Python 3.
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Graphical Python debugger"
HOMEPAGE="http://winpdb.org/ http://code.google.com/p/winpdb/ http://pypi.python.org/pypi/winpdb"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-python/pycrypto-2.0.1
	dev-python/wxpython:2.8"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="rpdb2.py winpdb.py"
