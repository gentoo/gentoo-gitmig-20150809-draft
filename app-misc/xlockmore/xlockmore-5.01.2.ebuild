# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/xlockmore/xlockmore-5.01.2.ebuild,v 1.2 2001/06/04 18:15:25 blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Just another screensaver application for X"
SRC_URI="ftp://ftp.tux.org/pub/tux/bagleyd/xlockmore/${A}"
HOMEPAGE="http://www.tux.org/~bagleyd/xlockmore.html"

DEPEND="opengl? ( >=media-libs/mesa-3.4.2 )"

src_compile() {

    local myconf
    if [ "`use pam`" ] ; then
    myconf="--enable-pam"
    fi
    if [ -z "`use nas`" ] ; then 
    myconf="--disable-nas"
    fi
    if [ "`use esd`" ] ; then
    myconf="--enable-esd"
    fi
    if [ -z "`use opengl`" ] ; then
    myconf="--disable-mesa"
    fi

    try ./configure --prefix=/usr --mandir=${prefix}/X11R6/man/man1 \
	--host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make prefix=${D}/usr mandir=${D}/usr/share/man install
    dodoc docs/* README

}

