# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/ktexmaker2/ktexmaker2-1.4.ebuild,v 1.5 2001/09/29 21:03:25 danarmak Exp $

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
      myconf="$myconf --enable-mitshm"
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make

}

src_install () {
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README TODO
}

