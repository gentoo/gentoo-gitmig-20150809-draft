# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg/mrtg-2.9.7.ebuild,v 1.1 2001/01/05 07:03:30 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool to monitor the traffic load on network-links"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/mrtg/pub/mrtg-2.9.7.tar.gz"
HOMEPAGE="http://ee-staff.ethz.ch/~oetiker/webtools/mrtg/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    rm -r ${D}/usr/doc
    dodoc ANNOUNCE COPYING CHANGES COPYRIGHT
    dodoc MANIFEST README THANKS
    docinto txt
    dodoc doc/*.txt
    docinto html
    dodoc doc/*.html images/*
}

