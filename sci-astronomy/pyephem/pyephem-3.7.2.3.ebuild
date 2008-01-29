# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/pyephem/pyephem-3.7.2.3.ebuild,v 1.1 2008/01/29 12:59:56 bicatali Exp $

inherit distutils

DESCRIPTION="Astronomical routines for the python programming language"
LICENSE="LGPL-3"
HOMEPAGE="http://rhodesmill.org/pyephem/pyephem.html"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_test() {
	# python setup.py test did not work, so do it manually
	cd build/lib*
	for t in angles bodies constants dates usno usno_equinoxes; do
		PYTHONPATH=. \
			"${python}" ephem/tests/test_${t}.py \
			|| die "test_${t} failed"
	done
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/* || die "Failed to install examples"
	mv "${D}"/usr/lib*/${python}*/site-packages/ephem/doc \
		"${D}"/usr/share/doc/${PF}/html || die "Failed to install doc"
}
