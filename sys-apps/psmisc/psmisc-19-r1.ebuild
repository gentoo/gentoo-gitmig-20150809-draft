# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-19-r1.ebuild,v 1.2 2000/08/16 04:38:29 drobbins Exp $

#from Debian ;)

P=psmisc-19      
A=${P}.tar.gz
S=${WORKDIR}/psmisc
DESCRIPTION="Handy process-related utilities from Debian"
SRC_URI="ftp://lrcftp.epfl.ch/pub/linux/local/psmisc/"${A}

src_compile() {                           
    make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/-ltermcap/-lncurses/g" -e "s/-O/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
    into /
    dobin fuser
    into /usr
    dobin killall pstree
    dosym killall /usr/bin/pidof
    doman *.1
    dodoc CHANGES COPYING README VERSION
}


