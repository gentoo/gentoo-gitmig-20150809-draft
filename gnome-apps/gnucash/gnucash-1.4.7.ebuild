# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnucash/gnucash-1.4.7.ebuild,v 1.1 2000/10/14 11:32:53 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A personal finance manager"
SRC_URI="http://download.sourceforge.net/gnucash/${A}"
HOMEPAGE="http://gnucash.sourceforge.net"


src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/gnome --host=${CHOST} --with-catgets
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

