# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A CVS Client for KDE"
SRC_URI="http://ftp1.sourceforge.net/cervisia/${A}"
HOMEPAGE="http://cervisia.sourceforge.net"

DEPEND=">=kde-base/kdelibs-2.0"
RDEPEND=$DEPEND

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST} \
		--with-kde-version=2 $myconf
    try make

}

src_install () {

    cd ${S}
    dodir /opt/kde2.1/man/man1
    try make prefix=${D}/opt/kde2.1 install

}


