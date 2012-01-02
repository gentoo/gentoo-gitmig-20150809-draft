# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/omnijson/omnijson-0.1.2.ebuild,v 1.1 2012/01/02 05:13:25 floppym Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Wraps the best JSON installed, falling back on an internal simplejson"
HOMEPAGE="http://pypi.python.org/pypi/omnijson"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
