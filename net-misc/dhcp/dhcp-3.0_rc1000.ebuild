# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0_rc1000.ebuild,v 1.1 2001/07/01 18:39:34 achim Exp $

P=dhcp-3.0rc10
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P}.tar.gz"
HOMEPAGE="http://www.isc.org/products/DHCP/"

DEPEND="virtual/glibc sys-apps/groff"
RDEPEND="virtual/glibc"
src_unpack() {
    unpack ${A}
    cd ${S}/includes
cat <<END >> site.h
#define _PATH_DHCPD_DB	"/etc/dhcp/dhcpd.leases"
#define _PATH_DHCPD_CONF "/etc/dhcp/dhcpd.conf"
#define _PATH_DHCLIENT_DB   "/var/lib/dhcp/dhclient.leases" 
END

}

src_compile() {

cat <<END > site.conf
CC = gcc ${CFLAGS}
ETC = /etc/dhcp
VARDB = /var/lib/dhcp
ADMMANDIR = /usr/share/man/man8
FFMANDIR = /usr/share/man/man5
LIBMANDIR = /usr/share/man/man3
END

  try ./configure --with-nsupdate
  try make

}

src_install2() {
  try make DESTDIR=${D} install
}

src_install () {

    cd ${S}/work.linux-2.2/client
    into /
    dosbin dhclient
    into /usr
    doman *.5 *.8

    cd ../common
    doman *.5

    cd ../dhcpctl
    dolib libdhcpctl.a
    insinto /usr/include
    doins dhcpctl.h
    doman *.3

    cd ../omapip
    dolib libomapi.a
    doman *.3

    cd ../relay
    dosbin dhcrelay
    doman *.8
   
    cd ../server
    dosbin dhcpd
    doman *.5 *.8

    cd ${S}/client
    insinto /etc/dhcp
    sed -e "s:/etc/dhclient-script:/sbin/dhclient-script:" dhclient.conf > ${D}/etc/dhcp/dhclient.conf.example
    exeinto /sbin
    newexe scripts/linux dhclient-script

    cd ${S}/server
    newins dhcpd.conf dhcpd.conf.example

    cd ${S}/includes/omapip
    insinto /usr/include/omapip
    doins alloc.h buffer.h omapip.h
    cd ${S}/includes/isc-dhcp
    insinto /usr/include/isc-dhco
    doins boolean.h dst.h int.h lang.h list.h result.h types.h
    dodir /var/lib/dhcp
    cd ${S}
    dodoc ANONCVS CHANGES COPYRIGHT README RELNOTES
    docinto doc
    dodoc  doc/*
}



