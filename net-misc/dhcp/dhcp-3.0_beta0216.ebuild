# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0_beta0216.ebuild,v 1.1 2001/02/10 18:03:19 achim Exp $

P=dhcp-3.0b2pl16
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P}.tar.gz"
HOMEPAGE="http://www.isc.org/products/DHCP/"

DEPEND="virtual/glibc"

src_compile() {

  cd ${S}
  echo "CC = gcc ${CFLAGS}" > site.conf
  echo "ETC = /etc/dhcp" >> site.conf
  try ./configure
  try make
}

src_install () {

    cd ${S}/work.linux-2.2/client
    into /usr
    dosbin dhclient
    doman *.5 *.8

    cd ../common
    doman *.5

    cd ../dhcpctl
    dolib libdhcpctl.a
    insinto /usr/include
    doins dhcpctl.h

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
    doins dhclient.conf
    donewins scripts/linux dhclient-script

    cd ${S}/server
    doins dhcpd.conf

    cd ${S}/includes/omapip
    insinto /usr/include/omapip
    doins alloc.h buffer.h omapip.h
    cd ${S}/includes/isc
    insinto /usr/include/isc
    doins boolean.h dst.h int.h lang.h list.h result.h types.h

    cd ${S}
    dodoc ANONCVS CHANGES COPYRIGHT README RELNOTES
    docinto doc
    dodoc  doc/*
}



