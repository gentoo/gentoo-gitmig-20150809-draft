# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ucd-snmp/ucd-snmp-4.2.6-r2.ebuild,v 1.3 2003/12/17 04:23:25 brad_mssw Exp $

inherit flag-o-matic

DESCRIPTION="Software for generating and retrieving SNMP data."
HOMEPAGE="http://net-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/net-snmp/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~hppa ~alpha ppc64"
IUSE="ssl ipv6 tcpd"

PROVIDE="virtual/snmp"
DEPEND="virtual/glibc
	<sys-libs/db-2
	>=sys-libs/zlib-1.1.4
	>=sys-apps/sed-4
	ssl? ( >=dev-libs/openssl-0.9.6d )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
RDEPEND="${DEPEND}
	!virtual/snmp"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Fix openssl-0.9.7 support, based on changes done to net-snmp
	# (bug #25595) - <azarah@gentoo.org> (23 Sep 2003).
	epatch "${FILESDIR}/${P}-openssl-0.9.7.patch"
	# Fix head/tail syntax.
	epatch "${FILESDIR}/${P}-coreutils-2.patch"
	# Fix race conditions when building parallel.
	epatch "${FILESDIR}/${P}-agent-parallel-fixes.patch"
	# Fix build not erroring out when a subdir fails.
	epatch "${FILESDIR}/${P}-Makefile-fixes.patch"
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with ssl openssl` `use_enable -ssl internal-md5`"
	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_enable ipv6`"

	if [ "`use ssl`" ] && has_version '=dev-libs/openssl-0.9.6*' ; then
		einfo "Found openssl version 0.9.6: adding extra flags."
		append-flags "-DSTRUCT_DES_KS_STRUCT_HAS_WEAK_KEY"
	fi

	econf \
		--with-sys-location="Unknown" \
		--with-sys-contact="root@Unknown" \
		--with-mib-modules="host smux" \
		--with-logfile=/var/log/ucd-snmpd.log \
		--with-persistent-directory=/var/lib/ucd-snmp \
		--with-zlib \
		${myconf}

	emake || die "compile problem"
}

src_install () {
	einstall exec_prefix="${D}/usr" persistentdir="${D}/var/lib/net-snmp"
	keepdir /etc/snmp /var/lib/ucd-snmp

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO
	newdoc EXAMPLE.conf.def EXAMPLE.conf

	exeinto /etc/init.d
	newexe "${FILESDIR}/snmpd.rc6" snmpd
	insinto /etc/conf.d
	newins "${FILESDIR}/snmpd.conf" snmpd
}
