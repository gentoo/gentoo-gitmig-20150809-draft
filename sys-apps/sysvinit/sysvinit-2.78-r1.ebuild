# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.78-r1.ebuild,v 1.4 2000/11/30 23:14:35 achim Exp $

P="sysvinit-2.78"      
A=${P}.tar.gz
S=${WORKDIR}/sysvinit-2.78
DESCRIPTION="System initialization schtuff"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/init/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	cd ${S}/src
	try pmake LDFLAGS=\"\"
	cd ${S}/contrib
	gcc start-stop-daemon.c -o start-stop-daemon
}

src_unpack() {
    unpack ${A}
    cd ${S}/src
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
	cd ${S}/src
	into /
	dosbin halt init killall5 runlevel shutdown sulogin 
	dobin last mesg utmpdump wall
	dosym killall5 /sbin/pidof
	dosym halt /sbin/reboot
	cd ${S}/contrib
	dosbin start-stop-daemon
	into /usr
	cd ${S}/man
	doman *.[1-9]

	cd ${S}
	dodoc README doc/* contrib/start-stop-daemon.README
	
}


