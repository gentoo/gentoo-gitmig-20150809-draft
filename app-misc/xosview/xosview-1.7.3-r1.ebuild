# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xosview/xosview-1.7.3-r1.ebuild,v 1.1 2001/10/06 15:30:15 danarmak Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X11 operating system viewer"
SRC_URI="http://linuxberg.surfnet.nl/files/x11/adm/${A}"
HOMEPAGE="http://lore.ece.utexas.edu/~bgrayson/xosview"

DEPEND="virtual/x11"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    exeinto /usr/bin
    doexe xosview
    insinto /usr/lib/X11
    cp Xdefaults XOsview
    doins XOsview
    into /usr
    doman *.1

}

