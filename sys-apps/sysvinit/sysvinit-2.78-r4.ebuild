# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysvinit/sysvinit-2.78-r4.ebuild,v 1.3 2001/08/21 03:10:05 drobbins Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="System initialization stuff"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/init/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="$DEPEND sys-apps/file"

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_compile() {
	pmake LDFLAGS="" || die
	cd ../contrib
	gcc ${CFLAGS} start-stop-daemon.c -o start-stop-daemon || die
}

src_install() {
	into /
	newsbin init init.system
	dosbin halt killall5 runlevel shutdown sulogin
	dosym init /sbin/telinit
	dobin last mesg utmpdump wall
	dosym killall5 /sbin/pidof
	dosym halt /sbin/reboot
	cd ../contrib
	dosbin start-stop-daemon
	into /usr
	cd ../man
	doman *.[1-9]
	cd ..
	dodoc README doc/* contrib/start-stop-daemon.README
}

pkg_postinst() {
	if [ ! -e ${ROOT}sbin/init ]
	then
		cp -a ${ROOT}sbin/init.system ${ROOT}sbin/init
	fi
}
