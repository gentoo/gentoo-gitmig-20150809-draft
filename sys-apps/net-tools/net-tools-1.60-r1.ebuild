# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60-r1.ebuild,v 1.1 2001/08/04 18:22:45 pete Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="standard Linux network tools"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${A}"
HOMEPAGE="http://sites.inka.de/lina/linux/NetTools/"

DEPEND="virtual/glibc
        sys-devel/gettext"
RDEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp ${FILESDIR}/config.h .
    cp ${FILESDIR}/config.make .
    cp Makefile Makefile.orig
    sed -e "s/-O2 -Wall -g/${CFLAGS}/" Makefile.orig > Makefile
    cd man
    cp Makefile Makefile.orig
    sed -e "s:/usr/man:/usr/share/man:" Makefile.orig > Makefile

}

src_compile() {

	try make ${MAKEOPTS}
	cd po
	try make ${MAKEOPTS}

}

src_install() {

	try make BASEDIR=${D} install
	mv ${D}/bin/* ${D}/sbin
	for i in hostname domainname netstat dnsdomainname ypdomainname nisdomainname
	do
	  mv ${D}/sbin/${i} ${D}/bin
	done
	dosym /bin/hostname /usr/bin/hostname
	
	if [ -z "`use bootcd`" ]
	then
		dodoc COPYING README README.ipv6 TODO
	else
		rm -rf ${D}/usr/share
	fi
}



