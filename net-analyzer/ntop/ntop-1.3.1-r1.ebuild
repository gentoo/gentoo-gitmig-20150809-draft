# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-1.3.1-r1.ebuild,v 1.1 2000/08/08 16:06:07 achim Exp $

P=ntop-1.3.1
A="${P}.tar.gz"
S=${WORKDIR}/${P}
CATEGORY="net-analyzer"
DESCRIPTION="Unix Tool that shows networkusage like top"
SRC_URI="ftp://ftp.it.ntop.org/pub/local/ntop/snapshots/${A}"
HOMEPAGE="http://www.ntop.org/ntop.html"


src_compile() {
    cd ${S}
    cp configure configure.orig
    sed -e "s:/usr/local/ssl:/usr:" configure.orig > configure
    CFLAGS="$CFLAGS -I/usr/include/openssl" ./configure --prefix=/usr --sysconfdir=/usr/share --host=${CHOST} 
    make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr sysconfdir=/${D}/usr/share install
    mv ${D}/usr/bin/plugins ${D}/usr/share/ntop
    prepman
    dodoc AUTHORS ChangeLog CONTENTS COPYING FAQ FILES HACKING
    dodoc KNOWN_BUGS MANIFESTO NEWS ntop.txt PORTING README*
    dodoc SUPPORT* THANKS THREADS-FAQ TODO
    docinto html
    dodoc ntop.html
}



