# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/xbatt/xbatt-1.2.1.ebuild,v 1.1 2001/07/31 11:43:07 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Notebook battery indicataor for X"
SRC_URI="http://www.clave.gr.jp/~eto/xbatt/${A}"
HOMEPAGE="http://www.clave.gr.jp/~eto/xbatt/"

DEPEND="virtual/x11"

src_compile() {
    try xmkmf
    try make xbatt
}

src_install () {
    try make DESTDIR=${D} install
    dodoc README* COPYRIGHT
}
