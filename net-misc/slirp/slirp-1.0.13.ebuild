# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom ryan@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/net-misc/slirp/slirp-1.0.13.ebuild,v 1.1 2001/05/30 01:33:05 ryan Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Emulates a PPP or SLIP connection over a terminal"
SRC_URI="http://download.sourceforge.net/slirp/slirp-1.0.13.tar.gz"
HOMEPAGE="http://slirp.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {

    cd src 
    try ./configure
    try make

}

src_install () {

    dobin src/slirp
    cp src/slirp.man slirp.1
    doman slirp.1
    dodoc docs/* README.NEXT README ChangeLog COPYRIGHT
    
}
