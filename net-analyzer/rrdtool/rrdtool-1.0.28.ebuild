# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rrdtool/rrdtool-1.0.28.ebuild,v 1.3 2001/06/04 00:16:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A system to store and display time-series data"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/rrdtool/pub/${A}"
HOMEPAGE="http://ee-staff.ethz.ca/~oetiker/webtools/rrdtool/"

DEPEND="virtual/glibc sys-devel/perl
        >=media-libs/libgd-1.8.3"

RDEPEND="virtual/glibc sys-devel/perl"

src_compile() {
    cd ${S}
    try ./configure --prefix=/opt/rrdtool --host=${CHOST}
    try make
}

src_install () {
    try make prefix=${D}/opt/rrdtool install
    try make PREFIX=${D}/usr site-perl-install
}
