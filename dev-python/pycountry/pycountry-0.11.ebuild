# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycountry/pycountry-0.11.ebuild,v 1.2 2009/09/08 02:54:35 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="ISO country, subdivision, language, currency and script definitions
and their translations"
HOMEPAGE=" http://pypi.python.org/pypi/pycountry/"
SRC_URI="http://pypi.python.org/packages/source/p/pycountry/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	distutils_src_install
	dodoc CHANGES.txt TODO.txt
}
