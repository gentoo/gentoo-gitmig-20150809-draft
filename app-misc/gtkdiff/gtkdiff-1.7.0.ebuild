# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtkdiff/gtkdiff-1.7.0.ebuild,v 1.1 2000/11/26 12:44:40 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK Frontend for diff"
SRC_URI="http://www.ainet.or.jp/~inoue/software/gtkdiff/${P}.tar.gz"
HOMEPAGE="http://www.ainet.or.jp/~inoue/software/gtkdiff/index-e.html"


src_compile() {

    cd ${S}
    local myconf
    try ./configure --prefix=/opt/gnome --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
}

