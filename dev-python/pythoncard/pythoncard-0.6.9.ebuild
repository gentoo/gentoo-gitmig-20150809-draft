# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.6.9.ebuild,v 1.3 2003/06/21 22:30:25 drobbins Exp $

DESCRIPTION="Cross-platform GUI construction kit for python"
SRC_URI="mirror://sourceforge/pythoncard/PythonCardPrototype-${PV}.tar.gz"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
LICENSE="PYTHON"

DEPEND="virtual/python
	>=dev-python/wxPython-2.3.2.1-r2"
SLOT="0"
KEYWORDS="x86 amd64"
S=${WORKDIR}/PythonCardPrototype-${PV}

src_compile() {
	python setup.py build || die    
}

src_install() {
	python setup.py install --prefix=${D}/usr || die "Install Failed"
	dodoc README.txt README_StyleEditor.txt
}




