# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-1.6.3.ebuild,v 1.8 2002/08/14 12:08:07 murphy Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An agent/software robot and a high level policy language for 
building expert systems to administrate and configure large computer 
networks" 

SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${A}"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

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



