# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.78-r4.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}/src
DESCRIPTION="System initialization stuff"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/init/${A}"
DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {

	try pmake LDFLAGS=""
	cd ../contrib
	try gcc ${CFLAGS} start-stop-daemon.c -o start-stop-daemon
}


src_install() {

	into /
	dosbin halt init killall5 runlevel shutdown sulogin
	dosym init /sbin/telinit
	dobin last mesg utmpdump wall
	dosym killall5 /sbin/pidof
	dosym halt /sbin/reboot
	cd ../contrib
	dosbin start-stop-daemon
	if [ -z "`use bootcd`" ]
	then
		into /usr
		cd ../man
		doman *.[1-9]
		cd ..
		dodoc README doc/* contrib/start-stop-daemon.README
	else
		rm -rf ${D}/usr/share
	fi

}
