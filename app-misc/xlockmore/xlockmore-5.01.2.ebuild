# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/xlockmore/xlockmore-5.01.2.ebuild,v 1.5 2001/06/07 14:13:37 blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Just another screensaver application for X"
SRC_URI="ftp://ftp.tux.org/pub/tux/bagleyd/xlockmore/${A}"
HOMEPAGE="http://www.tux.org/~bagleyd/xlockmore.html"

DEPEND="opengl? ( virtual/opengl )"

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
    cd xglock/
    make

}

src_install () {

    try make prefix=${D}/usr mandir=${D}/usr/X11R6/man/man1 install
    exeinto /usr/X11R6/bin
    doexe xmlock/xmlock
    doexe xglock/xglock
    dodoc docs/* README xglock/xglockrc xglock/README.xglock

}

