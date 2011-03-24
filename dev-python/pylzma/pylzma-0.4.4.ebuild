# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylzma/pylzma-0.4.4.ebuild,v 1.1 2011/03/24 16:20:20 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
# hashlib module required.
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

DESCRIPTION="Python bindings for the LZMA compression library"
HOMEPAGE="http://www.joachim-bauch.de/projects/python/pylzma/ http://pypi.python.org/pypi/pylzma"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-python/m2crypto"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="doc/usage.txt readme.txt"
PYTHON_MODNAME="py7zlib.py"
