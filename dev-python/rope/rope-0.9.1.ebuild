# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rope/rope-0.9.1.ebuild,v 1.1 2009/02/15 15:03:34 patrick Exp $

NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="Python refactoring library"
HOMEPAGE="http://rope.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_install() {
	distutils_src_install
	docinto docs
	dodoc docs/*.txt
}

src_test() {
	PYTHONPATH="." ${python} ropetest/__init__.py
}
