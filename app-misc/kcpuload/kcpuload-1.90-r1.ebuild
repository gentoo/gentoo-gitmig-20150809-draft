# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/kcpuload/kcpuload-1.90-r1.ebuild,v 1.5 2001/09/29 21:03:25 danarmak Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A CPU applet for KDE2"
SRC_URI="http://kde.quakenet.eu.org/files/${A}"
HOMEPAGE="http://kde.quakenet.eu.org/kcpuload.shtml"

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

