# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# $Header: /var/cvsroot/gentoo-x86/dev-python/Numeric/Numeric-19.0.0.ebuild,v 1.3 2001/08/31 03:23:38 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="numerical python module"
SRC_URI="http://prdownloads.sourceforge.net/numpy/"${A}
HOMEPAGE="http://www.pfdubois.com/numpy/"

DEPEND="virtual/python"

PYTHON_VERSION=
src_compile() {
  cd ${S}
  try python setup_all.py build    
}

src_install() {
  cd ${S}
  try python setup_all.py install --prefix=${D}/usr 
  dodoc MANIFEST
  dodoc PKG-INFO
  dodoc README*
#need to automate the python version in the path
  mv Demo/NumTut ${D}/usr/lib/python2.0/site-packages/
}




