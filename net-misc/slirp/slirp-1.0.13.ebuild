# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/slirp/slirp-1.0.13.ebuild,v 1.4 2002/08/01 11:40:16 seemant Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Emulates a PPP or SLIP connection over a terminal"
SRC_URI="http://download.sourceforge.net/slirp/slirp-1.0.13.tar.gz"
HOMEPAGE="http://slirp.sourceforge.net"
KEYWORDS="x86"
LICENSE="slirp"
SLOT="0"

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
