# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <g2boojum@hotmail.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/media-libs/pdflib/pdflib-4.0.1.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A library for generating PDF on the fly"
SRC_URI="http://www.pdflib.com/pdflib/download/${A}"
HOMEPAGE="http://www.pdflib.com"

DEPEND="tcltk? ( >=dev-lang/tcl-tk-8.2 )
	perl? ( >=sys-devel/perl-5.1 )
	python? ( >=dev-lang/python-2.0 )
	java? ( >=dev-lang/jdk-1.3 )"

src_compile() {
    local myconf
    if [ -z "`use tcltk`" ] ; then
	myconf="--with-tcl=no"
    fi
    if [ -z "`use perl`" ] ; then
	myconf="$myconf --with-perl=no"
    fi
    if [ -z "`use python`" ] ; then
	myconf="$myconf --with-py=no"
    fi
    if [ "`use java`" ] ; then
	myconf="$myconf --with-java=/opt/java"
    else
	myconf="$myconf --with-java=no"
    fi
    try ./configure --prefix=/usr --host=${CHOST} \
	--enable-cxx --disable-php $myconf
    try make

}

src_install () {

    try make prefix=${D}/usr install

}

