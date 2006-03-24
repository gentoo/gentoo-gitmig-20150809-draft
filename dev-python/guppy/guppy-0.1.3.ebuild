# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/guppy/guppy-0.1.3.ebuild,v 1.1 2006/03/24 16:42:35 marienz Exp $

inherit distutils eutils

DESCRIPTION="Guppy-PE -- A Python Programming Environment"
HOMEPAGE="http://guppy-pe.sourceforge.net/"
SRC_URI="http://guppy-pe.sourceforge.net/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/python-2.3"

DOCS="ANNOUNCE changelog"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-skip-tests.patch"
}

src_test() {
	"${python}" setup.py install --home="${T}/test" || die "test install failed"
	cd "${T}/test/lib/python"
	PYTHONPATH=. "${python}" guppy/heapy/test/test_all.py || die "test failed"
	rm -rf "${T}/test"
}

src_install() {
	distutils_src_install
	dohtml doc/*
}
