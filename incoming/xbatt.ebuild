# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Notebook battery indicataor for X"
SRC_URI="http://www.clave.gr.jp/~eto/xbatt/${A}"
HOMEPAGE=""

DEPEND="virtual/x11"

src_compile() {
    try xmkmf
    try make
}

src_install () {
    try make DESTDIR=${D} install
}
