# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/jed/jed-0.99.14.ebuild,v 1.2 2001/07/03 14:42:53 g2boojum Exp $

#P=
P0=${PN}-B0.99-14
A=${P0}.tar.bz2
S=${WORKDIR}/${P0}
DESCRIPTION="Console S-Lang-based editor"
SRC_URI="ftp://space.mit.edu/pub/davis/jed/v0.99/${A}"
HOMEPAGE="http://space.mit.edu/~davis/jed/"

DEPEND="virtual/glibc
        >=sys-libs/slang-1.3.11
        X? ( virtual/x11 )
        gpm? ( sys-libs/gpm )"

src_compile() {

    export JED_ROOT=/usr/share/jed
    try ./configure --prefix=$JED_ROOT --host=${CHOST} --bindir=/usr/bin --mandir=/usr/share/man
    if [ -n "`use gpm`" ] ; then
       cd src
       mv Makefile Makefile.orig
       sed -e 's/#MOUSEFLAGS/MOUSEFLAGS/' -e 's/#MOUSELIB/MOUSELIB/' -e 's/#GPMMOUSEO/GPMMOUSEO/' -e 's/#OBJGPMMOUSEO/OBJGPMMOUSEO/' Makefile.orig > Makefile 
       cd ..
    fi
    try make clean
    try make
    if [ -n "`use X`" ] ; then
       try make xjed
    fi

}

src_install () {

    try make DESTDIR=${D} install
    cd doc
    cp README AUTHORS
    cd ..
    dodoc COPYING COPYRIGHT INSTALL INSTALL.unx README doc/AUTHORS doc/manual/jed.tex
    insinto /usr/share/info
    doins info/*
    insinto /etc
    doins lib/jed.conf
    cd ${D}
    rm -rf usr/share/jed/info
    # can't rm usr/share/jed/doc -- used internally by jed/xjed

}

