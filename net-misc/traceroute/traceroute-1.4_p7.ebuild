# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/traceroute/traceroute-1.4_p7.ebuild,v 1.1 2000/11/22 09:09:16 jerry Exp $

P=traceroute-1.4a7
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to trace the route of ip packets"
SRC_URI="ftp://ftp.ee.lbl.gov/${A}"
HOMEPAGE="http://ee.lbl.gov/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    dosbin traceroute
    doman traceroute.8
    dodoc CHANGES INSTALL
}
