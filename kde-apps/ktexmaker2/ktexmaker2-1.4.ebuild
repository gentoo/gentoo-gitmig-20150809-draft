# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Latex Editor and TeX shell for kde2"
SRC_URI="http://xm1.net.free.fr/linux/${A}"
HOMEPAGE="http://xm1.net.free.fr/linux/"

DEPEND=">=kde-base/kdelibs-2.1.1 sys-devel/perl"
RDEPEND=">=kde-base/kdelibs-2.1.1"


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
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make

}

src_install () {
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README TODO
}

