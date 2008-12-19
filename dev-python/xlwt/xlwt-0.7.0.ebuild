# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlwt/xlwt-0.7.0.ebuild,v 1.2 2008/12/19 15:46:13 bicatali Exp $

EAPI=2
inherit distutils

DESCRIPTION="Python library to create spreadsheet files compatible with Excel"
HOMEPAGE="http://pypi.python.org/pypi/xlwt/"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

src_prepare() {
	sed -i \
		-e '/package_data/,+6d' \
		setup.py || die
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins -r HISTORY.html xlwt/doc/xlwt.html tests
	if use examples; then
		doins -r xlwt/examples
	fi
}
