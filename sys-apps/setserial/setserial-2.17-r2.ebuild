# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setserial/setserial-2.17-r2.ebuild,v 1.1 2001/02/07 15:51:28 achim Exp $

P=setserial-2.17
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Configure your serial ports with it"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/sources/sbin/${A}
	 ftp://ftp.sunsite.org.uk/Mirrors/tsx-11.mit.edu/pub/linux/sources/sbin/${A}"

DEPEND="virtual/glibc"

src_compile() {                           

    try ./configure 
    try pmake setserial

}

src_install() {      
                         
    doman setserial.8
    into /
    dobin setserial

    dodoc README 
    docinto txt
    dodoc Documentation/*
    insinto /etc
    doins serial.conf
}



