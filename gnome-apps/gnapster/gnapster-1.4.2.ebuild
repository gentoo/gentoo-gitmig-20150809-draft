# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-apps/gnapster/gnapster-1.3.12.ebuild,v 1.2 2000/11/03 17:47:44 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A napster client for GNOME"
SRC_URI="http://www.faradic.net/~jasta/files/${A}"
HOMEPAGE="http://www.faradic.net/~jasta/programs.html"

DEPEND=">=gnome-base/gnome-libs-1.2.10
        >=gnome-base/gdk-pixbuf-0.10.1"

src_compile() {

    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --prefix=/opt/gnome --host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make prefix=${D}/opt/gnome install

}

