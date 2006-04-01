# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyprotocols/pyprotocols-0.9.3.ebuild,v 1.2 2006/04/01 18:49:06 agriffis Exp $

inherit distutils

MY_PF=${PF/pypro/PyPro}
S=${WORKDIR}/${MY_PF}

SRC_URI="http://peak.telecommunity.com/dist/${MY_PF}.tar.gz"
DESCRIPTION="Adapter/protocol framework for Python"
HOMEPAGE="http://peak.telecommunity.com/PyProtocols.html"
LICENSE="ZPL"

SLOT="0"
IUSE=""
KEYWORDS="~ia64 ~ppc ~x86"

DEPEND="sys-devel/gcc
		>=dev-lang/python-2.2"

pkg_postinst() {
	distutils_pkg_postinst
}

src_test() {
	cd ${S}
	python setup.py test || die "Unit tests failed!"
}
