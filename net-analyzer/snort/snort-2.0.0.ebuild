# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.0.0.ebuild,v 1.2 2003/04/22 06:55:44 aliz Exp $

inherit eutils

IUSE="ssl postgres mysql snmp"
S=${WORKDIR}/${P}
DESCRIPTION="Libpcap-based packet sniffer/logger/lightweight IDS"
SRC_URI="http://www.snort.org/dl/${P}.tar.gz"
HOMEPAGE="http://www.snort.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.6.2-r1
	~net-libs/libnet-1.0.2a
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
	#is this needed in 2.0? -Method
	#epatch ${FILESDIR}/${P}-configure.patch

	# Following patch contributed in bug #18258
	#is this needed in 2.0? -Method
	#use alpha && epatch ${FILESDIR}/${P}-alpha.patch

	sed "s:var RULE_PATH ../rules:var RULE_PATH /etc/snort:" < etc/snort.conf > etc/snort.conf.distrib
}

src_compile() {

	local myconf

	use postgres && myconf="${myconf} --with-postgresql" \
		|| myconf="${myconf} --without-postgresql"
	use mysql && myconf="${myconf} --with-mysql" \
		|| myconf="${myconf} --without-mysql"
	use ssl && myconf="${myconf} --with-openssl" \
		|| myconf="${myconf} --without-openssl"
       use snmp && myconf="${myconf} --with-snmp" \
                || myconf="${myconf} --without-snmp"


	./configure \
		--prefix=/usr \
		--without-odbc \
		--without-oracle \
		--enable-pthreads \
		--enable-flexresp \
		--enable-smbalerts \
		--mandir=/usr/share/man \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install () {

	make DESTDIR=${D} install || die

	dodir /var/log/snort
	touch ${D}/var/log/snort/.keep

	insinto /usr/lib/snort/bin
	doins contrib/{create_mysql,snortlog,*.pl}

	dodoc COPYING LICENSE doc/*
	docinto contrib ; dodoc contrib/*

	insinto /etc/snort
	doins etc/reference.config etc/classification.config rules/*.rules
	doins etc/snort.conf.distrib

	exeinto /etc/init.d ; newexe ${FILESDIR}/snort.rc6 snort
	insinto /etc/conf.d ; newins ${FILESDIR}/snort.confd snort
}

pkg_postinst() {

	if ! grep -q ^snort: /etc/group ; then
		groupadd snort || die "problem adding group snort"
	fi
	if ! grep -q ^snort: /etc/passwd ; then
		useradd -g snort -s /dev/null -d /var/log/snort -c "snort" snort
		assert "problem adding user snort"
	fi
	usermod -c "snort" snort || die "usermod problem"
	usermod -d "/var/log/snort" snort || die "usermod problem"
	usermod -g "snort" snort || die "usermod problem"
	usermod -s "/dev/null" snort || die "usermod problem"
	echo "ignore any message about CREATE_HOME above..."

	chown snort.snort /var/log/snort
	chmod 0770 /var/log/snort
}
