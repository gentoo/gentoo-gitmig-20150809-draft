# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/dev-python/Numeric/Numeric-19.0.0.ebuild,v 1.3 2001/08/31 03:23:38 pm Exp

S=${WORKDIR}/${P}
DESCRIPTION="numerical python module"
SRC_URI="http://prdownloads.sourceforge.net/numpy/${P}.tar.gz"
HOMEPAGE="http://www.pfdubois.com/numpy/"

DEPEND="virtual/python"

src_compile() {
  
	python setup_all.py build || die    

}

src_install() {

	python setup_all.py install --prefix=${D}/usr || die 

	dodoc MANIFEST PKG-INFO README*

#grab python verision so ebuild doesn't depend on it
	local python_version
	python_version=$(python -V 2>&1 | sed -e 's/Python /python/')

#this needs work; change to use install
	cp -a Demo/NumTut ${D}/usr/lib/${python_version}/site-packages/
}




