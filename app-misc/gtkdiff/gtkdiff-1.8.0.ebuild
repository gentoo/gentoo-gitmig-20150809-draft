# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtkdiff/gtkdiff-1.8.0.ebuild,v 1.2 2001/06/11 08:11:28 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK Frontend for diff"
SRC_URI="http://www.ainet.or.jp/~inoue/software/gtkdiff/${P}.tar.gz"
HOMEPAGE="http://www.ainet.or.jp/~inoue/software/gtkdiff/index-e.html"

DEPEND=">=gnome-base/gnome-libs-1.2.8"

src_compile() {

    try ./configure --prefix=/opt/gnome --host=${CHOST}
    try pmake

}

src_install () {

    try make prefix=${D}/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
}

