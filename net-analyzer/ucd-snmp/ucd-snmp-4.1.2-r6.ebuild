# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ucd-snmp/ucd-snmp-4.1.2-r6.ebuild,v 1.1 2001/09/06 09:51:34 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Software for generating and retrieving SNMP data"
SRC_URI="http://download.sourceforge.net/net-snmp/${P}.tar.gz"
HOMEPAGE="http://net-snmp.sourceforge.net/"

DEPEND="virtual/glibc <sys-libs/db-2
        >=sys-libs/zlib-1.1.3
        ssl? ( >=dev-libs/openssl-0.9.6 )
        tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_compile() {
    local myconf
    use ssl && myconf="${myconf} --with-openssl=/usr"
    use ssl || myconf="${myconf} --enable-internal-md5 --with-openssl=no"
    use tcpd && myconf="${myconf} --with-libwrap"
    use ipv6 && myconf="${myconf} --with-ipv6"

    ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	--with-zlib --enable-shared --with-sys-contact="root@Unknown" \
	--with-sys-location="Unknown" --with-logfile=/var/log/snmpd.log \
	--with-persistent-directory=/var/lib/ucd-snmp ${myconf}
    assert
    emake || die
}

src_install () {
    make prefix=${D}/usr exec_prefix=${D}/usr mandir=${D}/usr/share/man \
	persistentdir=${D}/var/lib/ucd-snmp install || die

    dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO EXAMPLE.conf

    exeinto /etc/init.d
    newexe ${FILESDIR}/snmpd.rc6 snmpd
}
