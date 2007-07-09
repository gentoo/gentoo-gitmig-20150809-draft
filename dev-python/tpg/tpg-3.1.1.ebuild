# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tpg/tpg-3.1.1.ebuild,v 1.1 2007/07/09 20:11:52 lucass Exp $

inherit distutils

MY_P="TPG-${PV}"

DESCRIPTION="Toy Parser Generator for Python"
HOMEPAGE="http://christophe.delord.free.fr/tpg/index.html"
SRC_URI="http://christophe.delord.free.fr/soft/tpg/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc examples"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	dodoc THANKS

	use doc && dodoc doc/tpg.pdf

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	"${python}" tpg_tests.py -v || die "tests failed"
}
