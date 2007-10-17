# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/pyephem/pyephem-3.7.2.1.ebuild,v 1.1 2007/10/17 11:45:15 bicatali Exp $

inherit distutils

DESCRIPTION="PyEphem provides scientific-grade astronomical computations for the python programming language."
LICENSE="GPL-2"
HOMEPAGE="http://www.rhodesmill.org/brandon/projects/pyephem.html"
SRC_URI="http://www.rhodesmill.org/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/python"

src_test() {
	cd "${S}"/build/lib*
	PYTHONPATH=. "${S}"/test || die "tests failed"
}

src_install() {
	distutils_src_install

	# install docs and examples
	dohtml doc/* || die "Failed to install html docs"

	insinto /usr/share/${PN}/examples
	doins examples/* || die "Failed to install examples"
}
