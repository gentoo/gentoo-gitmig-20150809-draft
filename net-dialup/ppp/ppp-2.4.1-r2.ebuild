# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.1-r2.ebuild,v 1.3 2001/09/04 21:26:57 lamer Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Point-to-point protocol - used for communicating with your ISP"
SRC_URI="ftp://cs.anu.edu.au/pub/software/ppp/${A}"

DEPEND="virtual/glibc"

src_compile() {
    try ./configure --prefix=/usr
    #fix Makefiles to compile optimized
    cd pppd
    mv Makefile Makefile.orig
    sed -e "s:COPTS = -O2 -pipe -Wall -g:COPTS = ${CFLAGS}:" -e "s/LIBS =/LIBS = -lcrypt/" Makefile.orig > Makefile
    cd ../pppstats
    mv Makefile Makefile.orig
    sed -e "s:COPTS = -O:COPTS = ${CFLAGS}:" Makefile.orig > Makefile
    cd ../chat
    mv Makefile Makefile.orig
    sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
    cd ../pppdump
    mv Makefile Makefile.orig
    sed -e "s:CFLAGS= -O:CFLAGS= ${CFLAGS}:" Makefile.orig > Makefile
    cd ..
    export CC=gcc
    try make
}

src_install() {                               
    into /usr
    for y in chat pppd pppdump pppstats
    do
        doman ${y}/${y}.8
        dosbin ${y}/${y}
    done
    chmod u+s-w ${D}/usr/sbin/pppd
    chown root:daemon ${D}/usr/sbin/pppstats
    dodir /etc/ppp/peers
    insinto /etc/ppp
    insopts -m0600
    doins etc.ppp/pap-secrets etc.ppp/chap-secrets
    insopts -m0644
    doins etc.ppp/options
    dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	 # Added a couple scripts to simplify dialing up
	 # borrowed from debian, man they got some nice little apps :-)
	 dosbin ${FILESDIR}/pon
	 dosbin ${FILESDIR}/poff
	 doman  ${FILESDIR}/pon.1
}

pkg_postinst()	{

if [ ! -e /dev/ppp ]; then
	mknod /dev/ppp c 108 0
fi
}
