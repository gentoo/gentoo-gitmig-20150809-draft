# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $HEADER $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A system to store and display time-series data"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/rrdtool/pub/${A}"
HOMEPAGE="http://ee-staff.ethz.ca/~oetiker/webtools/rrdtool/"

DEPEND="virtual/glibc sys-devel/perl
        >=media-libs/libgd-1.8.3
	tcl? ( dev-lang/tcl )"

RDEPEND="virtual/glibc sys-devel/perl tcl? ( dev-lang/tcl )"

src_compile() {

    local myconf
    use tcl && myconf="--with-tcllib=/usr/lib"

    try ./configure --prefix=/opt/rrdtool ${myconf} --host=${CHOST} --with-perl-options='INSTALLMAN1DIR=${D}/usr/share/man/man1 INSTALLMAN3DIR=${D}/usr/share/man/man3'
    try make
}

src_install () {
    try make prefix=${D}/opt/rrdtool install
    try make PREFIX=${D}/usr site-perl-install
}
