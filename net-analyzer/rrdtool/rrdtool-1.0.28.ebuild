# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.0.28.ebuild,v 1.2 2000/12/08 12:09:38 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A system to store and display time-series data"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/rrdtool/pub/${A}"
HOMEPAGE="http://ee-staff.ethz.ca/~oetiker/webtools/rrdtool/"

DEPEND=">=sys-devel/perl-5.6.0
        >=sys-libs/glibc-2.1.3
        >=sys-libs/zlib-1.1.3
        >=media-libs/libgd-1.8.3
        >=media-libs/libpng-1.0.7"

src_compile() {
    cd ${S}
    try ./configure --prefix=/opt/rrdtool --host=${CHOST}
    try make
}

src_install () {
    try make prefix=${D}/opt/rrdtool install
    try make PREFIX=${D}/usr site-perl-install
}
