# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/guppy/guppy-0.1.3.ebuild,v 1.4 2006/06/06 22:27:26 carlo Exp $

NEED_PYTHON=2.3

inherit distutils eutils

DESCRIPTION="Guppy-PE -- A Python Programming Environment"
HOMEPAGE="http://guppy-pe.sourceforge.net/"
SRC_URI="http://guppy-pe.sourceforge.net/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

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
