# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv/virtualenv-1.0.ebuild,v 1.1 2008/04/03 00:24:53 pythonhead Exp $

NEED_PYTHON="2.3"

inherit distutils

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="http://pypi.python.org/pypi/virtualenv"
SRC_URI="http://pypi.python.org/packages/source/v/${PN}/${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
DEPEND=">=dev-python/setuptools-0.6_rc7-r1"
DOCS="docs/index.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm ez_setup.py
}

