# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ulrich Eck <ueck@net-labs.de>
# §Header$
# $Header: /var/cvsroot/gentoo-x86/dev-python/egenix-mx-base/egenix-mx-base-2.0.2.ebuild,v 1.3 2001/08/31 03:23:38 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="egenix utils for Python."
SRC_URI="http://www.lemburg.com/files/python/"${A}
HOMEPAGE="http://www.egenix.com/"

DEPEND="virtual/python"

src_compile() {
    cd ${S}
    try python setup.py build
}

src_install() {
    cd ${S}
    try python setup.py install --prefix=${D}/usr
}
