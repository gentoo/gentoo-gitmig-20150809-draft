# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ucd-snmp/ucd-snmp-4.2.3-r1.ebuild,v 1.3 2002/07/18 23:22:52 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Software for generating and retrieving SNMP data"
SRC_URI="http://download.sourceforge.net/net-snmp/${P}.tar.gz"
HOMEPAGE="http://net-snmp.sourceforge.net/"

DEPEND="<sys-libs/db-2
	>=sys-libs/zlib-1.1.3
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_compile() {
	local myconf
	use ssl || myconf="${myconf} --enable-internal-md5 --with-openssl=no"
	use tcpd && myconf="${myconf} --with-libwrap"
	use ipv6 && myconf="${myconf} --with-ipv6"

	./configure \
		--with-zlib \
		--prefix=/usr \
		--enable-shared \
		--mandir=/usr/share/man \
		--with-sys-location="Unknown" \
		--with-sys-contact="root@Unknown" \
		--with-logfile=/var/log/snmpd.log \
		--with-persistent-directory=/var/lib/ucd-snmp \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install () {
	make install \
		prefix=${D}/usr \
		exec_prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		persistentdir=${D}/var/lib/ucd-snmp || die

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO EXAMPLE.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/snmpd.rc6 snmpd
}
