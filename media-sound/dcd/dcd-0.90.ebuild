# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header:

S=${WORKDIR}/dcd-0.90
SRC_URI="http://www.technopagan.org/dcd/dcd-0.90.tar.bz2"

HOMEPAGE="http://www.technopagan.org/dcd"

DESCRIPTION="A simple command-line based CD Player"

DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    cat Makefile.orig | sed "s:PREFIX = .*$:PREFIX = \"${D}/usr\":" |\
    sed "s:# CDROM = /dev/cdroms/cdrom0:CDROM = \"/dev/cdroms/cdrom0\":"\
    > Makefile
   
}
 
src_compile() {

    try make EXTRA_CFLAGS=\"$CFLAGS\"

}

src_install() {

    try make PREFIX=${D}/usr install
    dodoc README BUGS

}
