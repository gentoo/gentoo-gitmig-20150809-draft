# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysklogd/sysklogd-1.4-r2.ebuild,v 1.2 2001/08/07 18:07:12 darks Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="standard log daemons"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${A}"

DEPEND="virtual/glibc"
RDEPEND="sys-devel/perl"

src_unpack() {

    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" Makefile.orig > Makefile

}

src_compile() {
	try pmake LDFLAGS=""
}

src_install() {

	dosbin syslogd klogd ${FILESDIR}/syslogd-listfiles
	doman *.[1-9] ${FILESDIR}/syslogd-listfiles.8

        exeinto /etc/cron.daily
        doexe ${FILESDIR}/syslog

	dodoc ANNOUNCE CHANGES COPYING MANIFEST NEWS README.1st README.linux
	exeinto /etc/rc.d/init.d
	doexe ${FILESDIR}/sysklogd
}


