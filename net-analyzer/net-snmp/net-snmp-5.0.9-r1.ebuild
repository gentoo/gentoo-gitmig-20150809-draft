# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/net-snmp/net-snmp-5.0.9-r1.ebuild,v 1.1 2003/09/19 21:49:33 max Exp $

DESCRIPTION="Software for generating and retrieving SNMP data."
HOMEPAGE="http://net-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/net-snmp/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~arm ~hppa ~alpha"
IUSE="ssl ipv6 tcpd"

PROVIDES="virtual/snmp"
DEPEND="virtual/glibc
	<sys-libs/db-2
	>=sys-libs/zlib-1.1.4
	>=sys-apps/sed-4
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6d )"
RDEPEND="${DEPEND}
	!virtual/snmp"

S="${WORKDIR}/${P%[a-z]}"

src_compile() {
	local myconf

	myconf="${myconf} `use_with ssl openssl` `use_enable -ssl internal-md5`"
	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_enable ipv6`"

	econf \
		--with-sys-location="Unknown" \
		--with-sys-contact="root@Unknown" \
		--with-default-snmp-version="3" \
		--with-mib-modules="host smux" \
		--with-logfile=/var/log/net-snmpd.log \
		--with-persistent-directory=/var/lib/net-snmp \
		--enable-ucd-snmp-compatibility \
		--with-zlib \
		${myconf}

	# Parallel build doesn't work.
	make || die "compile problem"
}

src_install () {
	einstall exec_prefix="${D}/usr" persistentdir="${D}/var/lib/net-snmp"

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING \
		README* TODO EXAMPLE.conf.def

	exeinto /etc/init.d
	newexe "${FILESDIR}/snmpd.rc6" snmpd
	insinto /etc/conf.d
	newins "${FILESDIR}/snmpd.conf" snmpd

	keepdir /var/lib/net-snmp
}
