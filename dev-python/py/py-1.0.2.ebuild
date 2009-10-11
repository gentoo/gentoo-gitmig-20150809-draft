# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py/py-1.0.2.ebuild,v 1.4 2009/10/11 19:57:05 nixnut Exp $

EAPI="2"

NEED_PYTHON="2.3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A library aiming to support agile and test-driven python development on various levels."
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"
HOMEPAGE="http://codespeak.net/py/"
KEYWORDS="~amd64 ~ia64 ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"
LICENSE="MIT"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
