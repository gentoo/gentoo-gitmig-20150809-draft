# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/cervisia/cervisia-0.7.1.ebuild,v 1.5 2000/11/07 10:21:02 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A CVS Client for KDE"
SRC_URI="http://download.sourceforge.net/cervisia/${A}"
HOMEPAGE="http://cervisia.sourceforge.net"

DEPEND=">=kde-base/kdelibs-2.0"
RDEPEND=$DEPEND

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/kde2 --host=${CHOST} \
		--with-kde-version=2
    try make

}

src_install () {

    cd ${S}
    dodir /opt/kde2/man/man1
    try make prefix=${D}/opt/kde2 install

}


