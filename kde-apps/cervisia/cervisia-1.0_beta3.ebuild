# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/cervisia/cervisia-1.0_beta3.ebuild,v 1.1 2001/01/30 22:00:20 achim Exp $

A=${PN}-1.0beta3.tar.gz
S=${WORKDIR}/${PN}-1.0beta3
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


