# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/asciitable/asciitable-0.4.0.ebuild,v 1.3 2010/12/18 17:54:16 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="An extensible ASCII table reader"
HOMEPAGE="http://cxc.harvard.edu/contrib/asciitable/ http://pypi.python.org/pypi/asciitable"
SRC_URI="http://cxc.harvard.edu/contrib/asciitable/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="asciitable.py"
