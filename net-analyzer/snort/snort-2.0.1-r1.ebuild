# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.0.1-r1.ebuild,v 1.1 2003/08/21 05:17:06 vapier Exp $

inherit eutils

DESCRIPTION="Libpcap-based packet sniffer/logger/lightweight IDS"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/${P}.tar.gz 
	prelude? ( mirror://gentoo/${P}+prelude.patch.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc -alpha"
IUSE="ssl postgres mysql prelude"
# snort 2.0.x does not support snmp yet Bug #26310
# IUSE="${IUSE} snmp"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.6.2-r1
	>=net-libs/libnet-1.0.2a-r3
	<net-libs/libnet-1.1
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	prelude? ( >=dev-libs/libprelude-0.8 )"
#	snmp? ( >=net-analyzer/net-snmp-5.0 )
RDEPEND="virtual/glibc 
	dev-lang/perl
	>=net-libs/libpcap-0.6.2-r1
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	prelude? ( >=dev-libs/libprelude-0.8 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	#is this needed in 2.0? -Method
	#epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch

	# Following patch contributed in bug #18258
	#is this needed in 2.0? -Method
	#use alpha && epatch ${FILESDIR}/${P}-alpha.patch

	sed "s:var RULE_PATH ../rules:var RULE_PATH /etc/snort:" < etc/snort.conf > etc/snort.conf.distrib

	use prelude && epatch ../${P}+prelude.patch
}

src_compile() {
#		`use_with snmp` \
	econf \
		`use_with postgres postgresql` \
		`use_with mysql` \
		`use_with ssl openssl` \
		`use_with prelude` \
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
	keepdir /var/log/snort/

	insinto /usr/lib/snort/bin
	doins contrib/{create_mysql,snortlog,*.pl}

	dodoc COPYING LICENSE doc/*
	docinto contrib ; dodoc contrib/*

	insinto /etc/snort
	doins etc/reference.config etc/classification.config rules/*.rules etc/*.map
	doins etc/snort.conf.distrib

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

	chown snort.snort /var/log/snort
	chmod 0770 /var/log/snort
}
