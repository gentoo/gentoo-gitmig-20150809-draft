# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/kapteyn/kapteyn-2.0.ebuild,v 1.1 2010/08/02 15:44:35 xarthisius Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Collection of python tools for astronomy"
HOMEPAGE="http://www.astro.rug.nl/software/kapteyn"
SRC_URI="http://www.astro.rug.nl/software/kapteyn/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-astronomy/wcslib
	dev-python/numpy"
RDEPEND="${DEPEND}"

RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	distutils_src_install
	dodoc doc/${PN}.pdf || die
}
