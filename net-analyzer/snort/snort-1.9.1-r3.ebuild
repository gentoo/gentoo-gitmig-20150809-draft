# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-1.9.1-r3.ebuild,v 1.1 2003/08/21 05:17:06 vapier Exp $

inherit eutils

DESCRIPTION="Libpcap-based packet sniffer/logger/lightweight IDS"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha"
IUSE="ssl postgres mysql snmp"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.6.2-r1
	>=net-libs/libnet-1.0.2a-r3
	<net-libs/libnet-1.1
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	snmp? ( >=net-analyzer/net-snmp-5.0 )"
RDEPEND="virtual/glibc 
	dev-lang/perl
	>=net-libs/libpcap-0.6.2-r1
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch

	# Fixes for alpha, and GLSA 200304-05
	use alpha && epatch ${FILESDIR}/${P}-alpha-core_vuln.diff
}

src_compile() {
	econf \
		`use_with postgres postgresql` \
		`use_with mysql` \
		`use_with ssl openssl` \
		`use_with snmp` \
		--without-odbc \
		--without-oracle \
		--enable-pthreads \
		--enable-flexresp \
		--enable-smbalerts \
		|| die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	dodir /var/log/snort
	touch ${D}/var/log/snort/.keep

	insinto /usr/lib/snort/bin
	doins contrib/{create_mysql,snortlog,*.pl}

	dodoc COPYING LICENSE doc/*
	docinto contrib ; dodoc contrib/*

	insinto /etc/snort
	doins etc/classification.config rules/*.rules
	newins etc/snort.conf snort.conf.distrib

	exeinto /etc/init.d ; newexe ${FILESDIR}/snort.rc6 snort
	insinto /etc/conf.d ; newins ${FILESDIR}/snort.confd snort
}

pkg_postinst() {
	enewgroup snort
	enewuser snort -1 /dev/null /var/log/snort snort
	usermod -d "/var/log/snort" snort || die "usermod problem"
	usermod -g "snort" snort || die "usermod problem"
	usermod -s "/dev/null" snort || die "usermod problem"
	echo "ignore any message about CREATE_HOME above..."

	chown snort.snort ${ROOT}/var/log/snort
	chmod 0770 ${ROOT}/var/log/snort
}
