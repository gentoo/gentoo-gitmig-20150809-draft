# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.10-r1.ebuild,v 1.5 2002/08/16 02:49:58 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PyChecker is a tool for finding common bugs in python source code."
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="BSD"

src_compile() {
	python setup.py build
}

src_install(){
	python setup.py install --root=${D} || die
	dodoc CHANGELOG COPYRIGHT KNOWN_BUGS MAINTAINERS
	dodoc pycheckrc README TODO 
}

