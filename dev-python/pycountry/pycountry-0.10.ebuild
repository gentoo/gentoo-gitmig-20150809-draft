# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycountry/pycountry-0.10.ebuild,v 1.1 2008/08/16 17:33:18 cedk Exp $

inherit distutils

DESCRIPTION="ISO country, subdivision, language, currency and script definitions
and their translations"
HOMEPAGE=" http://pypi.python.org/pypi/pycountry/"
SRC_URI="http://pypi.python.org/packages/source/p/pycountry/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	distutils_src_install
	dodoc CHANGES.txt TODO.txt
}
