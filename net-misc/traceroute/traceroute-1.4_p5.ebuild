# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/traceroute/traceroute-1.4_p5.ebuild,v 1.1 2001/01/01 18:45:28 drobbins Exp $

P=traceroute-1.4a5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to trace the route of ip packets"
SRC_URI="ftp://ftp.inr.ac.ru/ip_routing/lbl_tools/${A}"
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
