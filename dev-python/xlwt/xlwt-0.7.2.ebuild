# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlwt/xlwt-0.7.2.ebuild,v 1.3 2009/11/08 19:54:56 nixnut Exp $

EAPI=2
inherit distutils

DESCRIPTION="Python library to create spreadsheet files compatible with Excel"
HOMEPAGE="http://pypi.python.org/pypi/xlwt/"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples"

src_prepare() {
	# prevint installing from doc and examples in python libdir
	sed -i \
		-e '/package_data/,+6d' \
		setup.py || die
}

src_test() {
	cd "${S}"/tests
	PYTHONPATH=../build/lib "${python}" RKbug.py 1 || die "test failed"
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins -r HISTORY.html xlwt/doc/xlwt.html tests
	if use examples; then
		doins -r xlwt/examples || die
	fi
}
