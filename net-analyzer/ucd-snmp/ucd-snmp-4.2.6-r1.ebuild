# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ucd-snmp/ucd-snmp-4.2.6-r1.ebuild,v 1.1 2003/05/26 08:30:43 aliz Exp $

IUSE="ssl ipv6 tcpd"
PROVIDES="virtual/snmp"
S=${WORKDIR}/${P}
DESCRIPTION="Software for generating and retrieving SNMP data"
SRC_URI="mirror://sourceforge/net-snmp/${P}.tar.gz"
HOMEPAGE="http://net-snmp.sourceforge.net/"
DEPEND="<sys-libs/db-2
	>=sys-libs/zlib-1.1.4
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc hppa"

src_compile() {
	export SNMPCONFPATH="/etc/ucd-snmp"
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
		--with-mib-modules=host \
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

	dodir /etc/ucd-snmp
	insinto /etc/ucd-snmp
	newins EXAMPLE.conf snmpd.conf.dist
}
