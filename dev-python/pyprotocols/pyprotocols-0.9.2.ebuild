# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyprotocols/pyprotocols-0.9.2.ebuild,v 1.2 2004/07/17 19:13:47 dholm Exp $

inherit distutils

MY_PF=${PF/pypro/PyPro}
S=${WORKDIR}/${MY_PF}

SRC_URI="http://peak.telecommunity.com/dist/old/${MY_PF}.tar.gz"
DESCRIPTION="Adapter/protocol framework for Python"
HOMEPAGE="http://peak.telecommunity.com/PyProtocols.html"
LICENSE="ZPL"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

DEPEND="sys-devel/gcc
		>=dev-lang/python-2.2"

pkg_postinst() {
	distutils_pkg_postinst
}

# Needs patching so it doesn't try to rm stuff from ${ROOT} .. site-packages
#src_test() {
#	cd ${S}
#	python setup.py test || die "Unit tests failed!"
#}
