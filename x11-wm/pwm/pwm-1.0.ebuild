# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pwm/pwm-1.0.ebuild,v 1.1 2001/02/06 07:19:50 achim Exp $

S=${WORKDIR}/pwm-1.0
SRC_URI="http://www.students.tut.fi/~tuomov/dl/pwm-1.0.tar.gz"

HOMEPAGE="http://www.students.tut.fi/~tuomov/pwm"

DESCRIPTION="A lightweight window manager"

DEPEND=">=x11-base/xfree-4.0.1"


src_unpack() {

    unpack ${A}
    cd ${S}
    cp config.h config.orig
    sed -e "s:PREFIX\"/etc/pwm/\":\"/etc/X11/pwm/\":" \
        config.orig > config.h
    cp system.mk system.orig
    sed -e "s:-g -O2:${CFLAGS}:" system.orig > system.mk

}

src_compile() {

    try make

}

src_install() {

    try make PREFIX=${D}/usr/X11R6 ETCDIR=${D}/etc/X11 DOCDIR=${D}/usr/doc/${PF} install
    dodoc config.txt

}
