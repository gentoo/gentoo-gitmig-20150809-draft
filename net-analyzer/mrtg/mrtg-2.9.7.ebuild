# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg/mrtg-2.9.7.ebuild,v 1.3 2001/06/04 00:16:12 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool to monitor the traffic load on network-links"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/mrtg/pub/mrtg-2.9.7.tar.gz"
HOMEPAGE="http://ee-staff.ethz.ch/~oetiker/webtools/mrtg/"

DEPEND="virtual/glibc sys-devel/perl >=media-libs/libgd-1.8.3"
RDEPEND="virtual/glibc sys-devel/perl >=media-libs/libpng-1.0.10 "

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr install
    dodir /usr/share/man
    mv ${D}/usr/man/man1 ${D}/usr/share/man
    rm -rf ${D}/usr/man
    rm -r ${D}/usr/doc
    dodoc ANNOUNCE COPYING CHANGES COPYRIGHT
    dodoc MANIFEST README THANKS
    docinto txt
    dodoc doc/*.txt
    docinto html
    dodoc doc/*.html images/*
}

