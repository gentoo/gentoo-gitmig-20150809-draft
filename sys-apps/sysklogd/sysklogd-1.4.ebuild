# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysklogd/sysklogd-1.4.ebuild,v 1.1 2000/10/03 16:02:05 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="standard log daemons"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${A}"

src_compile() {                           
	try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
	into /usr
	dosbin syslogd klogd ${FILESDIR}/syslogd-listfiles
	doman *.[1-9] ${FILESDIR}/syslogd-listfiles.8
	dodir /etc/cron.daily
	cp ${O}/files/syslog ${D}/etc/cron.daily
	dodoc ANNOUNCE CHANGES COPYING MANIFEST NEWS README.1st README.linux
}


