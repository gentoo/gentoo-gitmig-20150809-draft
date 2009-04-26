# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decorator/decorator-2.3.2.ebuild,v 1.1 2009/04/26 09:04:49 patrick Exp $

inherit distutils

DESCRIPTION="Simplifies the usage of decorators for the average programmer"
HOMEPAGE="http://www.phyast.pitt.edu/~micheles/python/documentation.html"
SRC_URI="http://pypi.python.org/packages/source/D/decorator/${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc"
DEPEND="app-arch/unzip"
RDEPEND=""
DOCS="CHANGES.txt documentation.txt"

src_install() {
	distutils_src_install
	use doc && dohtml documentation.html
}
