# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# Script Revised by Parag Mehta <pm@gnuos.org>
# /home/cvsroot/gentoo-x86/net-misc/bind/bind-9.1.3.ebuild,v 1.2 2001/05/28 14:32:32 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Bind - Name Server"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${PV}/${A}"
HOMEPAGE="http://www.isc.org/products/BIND"

DEPEND="virtual/glibc sys-apps/groff"
RDEPEND="virtual/glibc"

#this service should be upgraded to offer optional supervise support

src_unpack() {
	unpack ${A}
	cd ${S}/doc/man
	#fix man pages to reflect Gentoo Linux file locations (drobbins)
	local x
	for x in */*
	do
		cp ${x} ${x}.orig
		sed -e 's:/etc/named.conf:/etc/bind/named.conf:g' -e 's:/etc/rndc.conf:/etc/bind/rndc.conf:g' ${x}.orig > ${x}
		rm ${x}.orig
	done
}

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} --sysconfdir=/etc/bind --localstatedir=/var --with-libtool
    try make all
}

src_install() {
	dodir /usr/bin
	try make DESTDIR=${D} install
	doman doc/man/*/*.[1-8]
	dodir /etc/rc.d/init.d
	cp ${FILESDIR}/named ${D}/etc/rc.d/init.d
	dodir /etc/bind
	cp ${FILESDIR}/named.conf ${D}/etc/bind/named.conf
	cd ${S}/doc/arm
	dodoc *.html
	dodir /var/bind
	dodir /var/bind/pri
	dodir /var/bind/sec
	cp $(FILESDIR)/root.cache /var/bind
	cp $(FILESDIR)/locahost /var/bind/pri/localhost
	cp $(FILESDIR)/127.0.0 /var/bind/pri/127.0.0
}

#bind needs config files set up correctly before it should be enabled.
#pkg_config() {
#    . ${ROOT}/etc/rc.d/config/functions
#
#    echo "BIND enabled."
#}
