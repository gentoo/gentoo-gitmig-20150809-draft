# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/dev-python/scientific--python/ScientificPython-2.2.ebuild,v 1.4 2001/06/04 21:57:52 achim Exp
# $Header: /var/cvsroot/gentoo-x86/dev-python/ScientificPython/ScientificPython-2.2.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="scientific python module"
SRC_URI="http://starship.python.net/crew/hinsen/"${A}
HOMEPAGE="http://starship.python.net/crew/hinsen/scientific.html"

DEPEND=">=dev-lang/python-2.0-r4
        >=dev-python/Numeric-19.0
        >=app-misc/netcdf-3.0"
	
src_compile() {
  try python setup.py build    
}

src_install() {
  try python setup.py install --prefix=${D}/usr 
  dodoc MANIFEST.in
  dodoc COPYRIGHT
  dodoc README*
}
