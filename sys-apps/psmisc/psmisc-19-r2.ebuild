# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-19-r2.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

#from Debian ;)

A=${P}.tar.gz
S=${WORKDIR}/psmisc
DESCRIPTION="Handy process-related utilities from Debian"
SRC_URI="ftp://lrcftp.epfl.ch/pub/linux/local/psmisc/"${A}
DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/-ltermcap/-lncurses/g" -e "s/-O/${CFLAGS}/" -e "s:-Wpointer-arith::" Makefile.orig > Makefile
}

src_compile() {
    try pmake
}

src_install() {

    dobin killall pstree
    dosym killall /usr/bin/pidof

    into /
    dobin fuser

    doman *.1

    dodoc CHANGES COPYING README VERSION psmisc-19.lsm
}


