# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcp-wrappers/tcp-wrappers-7.6-r1.ebuild,v 1.2 2000/08/16 04:38:31 drobbins Exp $

P=tcp-wrappers-7.6      
A=tcp_wrappers_7.6.tar.gz
A0="tcp_wrappers_7.6.patch"
S=${WORKDIR}/tcp_wrappers_7.6
DESCRIPTION="tcp wrappers"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${A}"


src_unpack() {
    unpack ${A}
    cd ${S}/
    patch -p1 < ${O}/files/${A0}
    cp Makefile Makefile.orig
    sed -e "s/-O/${CFLAGS}/" \
	-e "s:AUX_OBJ=.*:AUX_OBJ= \\\:" Makefile.orig > Makefile
}

src_compile() {                           
    make REAL_DAEMON_DIR=/usr/sbin linux
}

src_install() {     
    into /usr                          
    mkdir -p ${D}/usr/sbin
    for i in tcpd tcpdchk tcpdmatch safe_finger try-from;
    do 
	dosbin ${i}
    done
    doman *.[358]
    dolib.a libwrap.a
    insinto /usr/include
    doins tcpd.h
    dodoc BLURB CHANGES DISCLAIMER README*
}





