# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pupynere/pupynere-1.0.13.ebuild,v 1.2 2010/06/30 03:17:55 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Pupynere is a PUre PYthon NEtcdf REader."
HOMEPAGE="http://pypi.python.org/pypi/pupynere/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="pupynere.py"
