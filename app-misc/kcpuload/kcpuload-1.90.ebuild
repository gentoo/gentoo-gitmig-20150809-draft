# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/kde-apps/kmago/kmago-0.5.ebuild,v 1.1 2000/11/15 16:33:15 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A CPU applet for KDE2"
SRC_URI="http://kde.quakenet.eu.org/files/${A}"
HOMEPAGE="http://kde.quakenet.eu.org/kcpuload.shtml"

DEPEND=">=kde-base/kdelibs-2.0"

RDEPEND=$DEPEND

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/kde2.1 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

