# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /home/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-0.3.1.ebuild,v 1.1

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Kmsn 0.3.1"
SRC_URI="http://prdownloads.sourceforge.net/kmsn/kmerlin-0.3.1.tar.gz"

HOMEPAGE="http://kmsn.sourceforge.net"

DEPEND="virtual/glibc
         	>=x11-libs/qt-x11-2.2.1
        	>=kde-base/kdebase-2.1"

src_compile() {

    ./configure --prefix=${KDEDIR} --host=${CHOST} || die
    make || die

}
src_install() {
  make prefix=${D}/usr install || die
}

