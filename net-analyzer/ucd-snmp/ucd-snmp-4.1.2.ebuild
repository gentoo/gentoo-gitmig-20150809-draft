# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ucd-snmp/ucd-snmp-4.1.2.ebuild,v 1.1 2000/11/07 06:41:31 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Software for generating and retrieving SNMP data"
SRC_URI="http://download.sourceforge.net/net-snmp/${A}"
HOMEPAGE="http://net-snmp.sourceforge.net/"

DEPEND=">=sys-libs/glibc-2.1.3
        >=sys-libs/zlib-1.1.3
        >=dev-libs/openssl-0.9.6
        >=sys-apps/tcp-wrappers-7.6
        >=sys-devel/perl-5.6.0"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
        --with-openssl --with-libwrap --with-zlib
    try make
}

src_install () {
    cd ${S}
    try make prefix=${D}/usr exec_prefix=${D}/usr \
        persistentdir=${D}/var/ucd-snmp install

    dodir /etc/rc.d/init.d/
    cp ${O}/files/snmpd ${D}/etc/rc.d/init.d/snmpd
}

pkg_config() {
    ${ROOT}/usr/sbin/rc-update add snmpd
}
