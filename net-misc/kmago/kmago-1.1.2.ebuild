# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/kmago/kmago-1.1.2.ebuild,v 1.9 2002/08/14 12:08:08 murphy Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Download Apllication for KDE2 based on wget"
SRC_URI="http://download.sourceforge.net/kmago/${A}"
HOMEPAGE="http://kmago.sourceforge.net"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=kde-base/kdelibs-2.1.1"

RDEPEND=$DEPEND

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

