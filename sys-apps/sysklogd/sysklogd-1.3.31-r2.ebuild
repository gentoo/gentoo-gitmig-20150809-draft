# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysklogd/sysklogd-1.3.31-r2.ebuild,v 1.1 2000/08/28 15:06:20 achim Exp $

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
	chmod +x debian/syslogd-listfiles
	dosbin syslogd klogd debian/syslogd-listfiles
	doman *.[1-9] debian/syslogd-listfiles.8
	dodir /etc/cron.daily
	cp ${O}/files/syslog ${D}/etc/cron.daily
	dodoc ANNOUNCE COPYING MANIFEST NEWS README.1st README.linux Sysklogd-1.3.lsm
	docinto debian
	dodoc debian/*
}


