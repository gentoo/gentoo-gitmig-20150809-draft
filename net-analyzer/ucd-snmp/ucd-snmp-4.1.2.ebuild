# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ucd-snmp/ucd-snmp-4.1.2.ebuild,v 1.4 2001/06/09 14:11:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Software for generating and retrieving SNMP data"
SRC_URI="http://download.sourceforge.net/net-snmp/${A}"
HOMEPAGE="http://net-snmp.sourceforge.net/"

DEPEND="virtual/glibc <sys-libs/db-2
        >=sys-libs/zlib-1.1.3
        ssl? ( >=dev-libs/openssl-0.9.6 )
        tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

RDEPEND="virtual/glibc <sys-libs/db-2
        ssl? ( >=dev-libs/openssl-0.9.6 )
        >=sys-libs/zlib-1.1.3"

src_compile() {
    local myconf
    if [ "`use ssl`" ] ; then
      myconf="--with-openssl=/usr"
    else
      myconf="--enable-internal-md5 --with-openssl=no"
    fi
    if [ "`use tcpd`" ] ; then
      myconf="--with-libwrap"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
        $myconf --with-zlib --enable-shared --enable-ipv6 \
        --with-sys-contact=\"root\@Unknown\" \
        --with-sys-location="Unknown" \
        --with-logfile=/var/log/snmpd.log \
        --with-persistent-directory=/var/lib/ucd-snmp

    try make
}

src_install () {
    try make prefix=${D}/usr exec_prefix=${D}/usr \
        mandir=${D}/usr/share/man \
        persistentdir=${D}/var/lib/ucd-snmp install

    dodir /etc/rc.d/init.d
    cp ${FILESDIR}/snmpd ${D}/etc/rc.d/init.d/snmpd
}

pkg_config() {
    ${ROOT}/usr/sbin/rc-update add snmpd
}
