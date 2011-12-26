# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/timelib/timelib-0.2.3.ebuild,v 1.1 2011/12/26 07:43:44 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="parse english textual date descriptions"
HOMEPAGE="http://pypi.python.org/pypi/timelib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZLIB PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_CFLAGS=("* + -fno-strict-aliasing")
