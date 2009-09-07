# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/guppy/guppy-0.1.9.ebuild,v 1.1 2009/09/07 19:45:37 patrick Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Guppy-PE -- A Python Programming Environment"
HOMEPAGE="http://guppy-pe.sourceforge.net/"
SRC_URI="http://pypi.python.org/packages/source/g/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS="ANNOUNCE changelog"

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
