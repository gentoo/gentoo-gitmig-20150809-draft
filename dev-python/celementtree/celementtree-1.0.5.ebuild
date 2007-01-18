# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celementtree/celementtree-1.0.5.ebuild,v 1.6 2007/01/18 23:39:03 lucass Exp $

inherit distutils

MY_P="cElementTree-${PV}-20051216"
DESCRIPTION="The cElementTree module is a C implementation of the ElementTree API"
HOMEPAGE="http://effbot.org/zone/celementtree.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="ElementTree"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"

IUSE="doc"
DEPEND=">=dev-lang/python-2.1.3-r1
	>=dev-python/elementtree-1.2"
S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}/samples
		doins samples/*
		doins selftest.py
	fi
}

src_test() {
	"${python}" setup.py install --home="${T}/test" || die "test copy failed"
	PYTHONPATH="${T}/test/lib/python" \
		"${python}" selftest.py || die "selftest.py failed"
	rm -rf "${T}/test"
}
