# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r3.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

P=netkit-base-0.17
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard linux net thingees -- inetd, ping"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure
    cp MCONFIG MCONFIG.orig
    #sed -e "s/-O2/${CFLAGS}  -Wstrict-prototypes -fomit-frame-pointer/"
    sed -e "s:^CFLAGS=.*:CFLAGS=${CFLAGS} -Wall -Wbad-function-cast -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Winline:" \
    MCONFIG.orig > MCONFIG

    try make ${MAKEOPTS}
}


src_install() {
    into /
    dobin ping/ping
	if [ -z "`use bootcd`" ]
	then
		into /usr
		dosbin inetd/inetd
		doman inetd/inetd.8 inetd/daemon.3 ping/ping.8
		
		dodoc BUGS ChangeLog README
		docinto samples
		dodoc etc.sample/*
	fi
}



