# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An agent/software robot and a high level policy language for 
building expert systems to administrate and configure large computer 
networks" 

SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${A}"
HOMEPAGE="http://www.iu.hio.no/cfengine/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=app-text/tetex-1.0.7-r2"

src_compile() {

    cd ${S}
    try ./configure 

    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    try make DESTDIR=${D}/doc install
    dodoc COPYING ChangeLog README 
}



