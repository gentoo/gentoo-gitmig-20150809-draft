# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Taras Glek <taras.glek@home.com>
# /home/cvsroot/gentoo-x86/net-www/amaya/amaya-4.1-r1.ebuild,v 1.1 2001/10/06 11:33:58 verwilst Exp

S=${WORKDIR}/${P}
DESCRIPTION="A very fast and light weight gtk browser"
SRC_URI="http://download.sourceforge.net/dillo/${P}.tar.gz" 
SSL_PATCH=dillo_https.diff.gz
if [ "`use ssl`" ] ; then
    SRC_URI="$SRC_URI http://www.lysator.liu.se/~torkel/computer/ipaq/$SSL_PATCH"
fi
HOMEPAGE="http://dillo.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.10-r4"
RDEPEND=">=x11-libs/gtk+-1.2.10-r4"

src_compile() {

    if [ "`use ssl`" ] ; then
        gzip -dc ${DISTDIR}/${SSL_PATCH} | patch -p1 
    fi
    try ./configure --prefix=${D}/usr --host=${CHOST} 
    try make

}

src_install () {

    dodir /usr
    dodir /usr/bin
    try make prefix=${D}/usr install
    
}

