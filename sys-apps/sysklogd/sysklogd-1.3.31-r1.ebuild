# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysklogd/sysklogd-1.3.31-r1.ebuild,v 1.2 2000/08/16 04:38:30 drobbins Exp $

P=sysklogd-1.3.31      
A=sysklogd-1.3-31.tar.gz
S=${WORKDIR}/sysklogd-1.3-31
DESCRIPTION="standard log daemons"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${A}"

src_compile() {                           
	make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
	into /usr
	dosbin syslogd klogd
	doman *.[1-9]
	dodoc ANNOUNCE COPYING MANIFEST NEWS README.1st README.linux Sysklogd-1.3.lsm
	docinto debian
	dodoc debian/*
}


