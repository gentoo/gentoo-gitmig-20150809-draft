# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0b1pl17.ebuild,v 1.1 2000/08/09 22:58:28 achim Exp $

P=dhcp-3.0b1pl17
A="${P}.tar.gz"
S=${WORKDIR}/${P}
CATEGORY="net-misc"
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P}.tar.gz"
HOMEPAGE="http://www.isc.org/products/DHCP/"


src_compile() {

  cd ${S}
  echo "CC = gcc ${CFLAGS}" > site.conf
  echo "ETC = /etc/dhcp" >> site.conf
  ./configure
  make
}

src_install () {

    cd ${S}/client
    into /usr
    dosbin dhclient
    doman *.5 *.8
    insinto /etc/dhcp
    doins dhclient.conf
    newins scripts/linux dhclient-script

    cd ${S}/common
    doman *.5

    cd ${S}/relay
    dosbin dhcrelay
    doman *.8
   
    cd ${S}/server
    dosbin dhcpd
    doman *.5 *.8
    doins dhcpd.conf

    cd ${S}
    dodoc COPYRIGHT DOCUMENTATION ISC-LICENSE README RELNOTES
    docinto doc
    dodoc  doc/*
}


