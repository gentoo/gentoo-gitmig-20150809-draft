# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.10-r1.ebuild,v 1.12 2003/04/23 15:25:26 vapier Exp $

DESCRIPTION="tool for finding common bugs in python source code"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="BSD"

DEPEND="virtual/python"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} || die
	dodoc CHANGELOG KNOWN_BUGS MAINTAINERS pycheckrc README TODO 
}
