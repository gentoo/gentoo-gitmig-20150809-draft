# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cervisia/cervisia-1.3.ebuild,v 1.6 2001/11/10 12:45:09 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A CVS Client for KDE"
SRC_URI="http://ftp1.sourceforge.net/cervisia/${P}.tar.gz"
HOMEPAGE="http://cervisia.sourceforge.net"

DEPEND=">=kde-base/kdelibs-2.0"
RDEPEND=$DEPEND

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    try ./configure --prefix=${KDEDIR} --host=${CHOST} \
		--with-kde-version=2 $myconf
    try make

}

src_install () {

    cd ${S}
    dodir /opt/kde2.1/man/man1
    try make prefix=${D}/opt/kde2.1 install

}


