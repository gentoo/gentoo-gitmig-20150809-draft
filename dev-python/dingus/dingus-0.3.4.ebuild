# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dingus/dingus-0.3.4.ebuild,v 1.1 2012/04/18 16:19:30 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="A record-then-assert mocking library"
HOMEPAGE="http://pypi.python.org/pypi/dingus/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"
