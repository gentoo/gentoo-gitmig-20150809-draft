# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/pcmcia-cs/pcmcia-cs-3.1.25.ebuild,v 1.1 2001/05/03 11:21:22 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Linux PCMCIA Card Services"
SRC_URI="http://prdownloads.sourceforge.net/pcmcia-cs/${A}"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

