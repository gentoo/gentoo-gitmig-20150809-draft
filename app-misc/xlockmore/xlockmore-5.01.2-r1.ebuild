# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/xlockmore/xlockmore-5.01.2-r1.ebuild,v 1.1 2001/10/06 15:30:15 danarmak Exp $

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

    ./configure --prefix=/usr --mandir=${prefix}/man/man1 \
	--host=${CHOST} ${myconf} || die
    make || die
    cd xglock/
    make

}

src_install () {

    make prefix=${D}/usr mandir=${D}/usr/man/man1 install || die
    exeinto /usr/bin
    doexe xmlock/xmlock
    doexe xglock/xglock
    dodoc docs/* README xglock/xglockrc xglock/README.xglock

}

