# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /home/cvsroot/gentoo-x86/net-misc/qtella-0.2.3.ebuild

S=${WORKDIR}/${P}
DESCRIPTION="QTella 0.2.3"
SRC_URI="http://prdownloads.sourceforge.net/qtella/qtella-0.2.3.tar.gz"

HOMEPAGE="http://qtella.sourceforge.net"

DEPEND="virtual/glibc
         	>=x11-libs/qt-x11-2.2.1
        	>=kde-base/kdelibs-2.1"

src_compile() {

    ./configure --prefix=${KDEDIR} --host=${CHOST} || die
    make || die

}
src_install() {
  make prefix=${D}/usr install || die
}

