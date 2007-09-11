# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/pyephem/pyephem-3.7.2a.ebuild,v 1.1 2007/09/11 13:57:59 bicatali Exp $

inherit distutils

DESCRIPTION="PyEphem provides scientific-grade astronomical computations for the python programming language."
LICENSE="GPL-2"
HOMEPAGE="http://www.rhodesmill.org/brandon/projects/pyephem.html"
SRC_URI="http://www.rhodesmill.org/brandon/projects/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/python"

src_test() {
	cd "${S}"/build/lib*
	for t in "${S}"/test/test_*.py ; do
		einfo "Testing $(basename ${t})"
		PYTHONPATH=. "${python}" ${t} 2>&1 | tee test.log
		grep -q '^OK' test.log || die "${t} failed"
		rm -f test.log
	done
}

src_install() {
	distutils_src_install

	# install docs and examples
	dohtml doc/* || die "Failed to install html docs"

	insinto /usr/share/${PN}/examples
	doins examples/* || die "Failed to install examples"
}
