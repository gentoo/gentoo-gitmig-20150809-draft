# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.1.3.ebuild,v 1.6 2004/10/29 19:47:51 eldad Exp $

inherit eutils gnuconfig

DESCRIPTION="Libpcap-based packet sniffer/logger/lightweight IDS"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/${P}.tar.gz
	snortsam? ( http://www.snortsam.net/files/snort-plugin/snortsam-patch.tar.gz )"
#	prelude? ( http://www.prelude-ids.org/download/releases/snort-prelude-reporting-patch-0.2.5.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc -alpha ~amd64 ~ppc"
IUSE="ssl postgres mysql flexresp selinux snortsam"

# Local useflag snortsam: patch snort for use with snortsam package.

# snort 2.1.x does not have prelude patches yet
# IUSE="${IUSE} prelude"
# snort 2.1.x has discontinued smb alert output, and no 3rd party have done them yet
# IUSE="${IUSE} samba"
# snort 2.0.x does not support snmp yet Bug #26310 (2.1.x doesn't have SNMP either)
# IUSE="${IUSE} snmp"


DEPEND="virtual/libc
	>=dev-libs/libpcre-4.2-r1
	>=net-libs/libpcap-0.6.2-r1
	flexresp? (	<net-libs/libnet-1.1
				>=net-libs/libnet-1.0.2a-r3 )
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"
#	prelude? ( >=dev-libs/libprelude-0.8 )
#	snmp? ( >=net-analyzer/net-snmp-5.0 )
RDEPEND="virtual/libc
	>=dev-libs/libpcre-4.2-r1
	dev-lang/perl
	>=net-libs/libpcap-0.6.2-r1
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	selinux? ( sec-policy/selinux-snort )
	snortsam? ( net-analyzer/snortsam )"
#	samba? ( net-fs/samba )
#	prelude? ( >=dev-libs/libprelude-0.8 )

src_unpack() {
	unpack ${A}

	cd ${S}
	gnuconfig_update

	#is this needed in 2.0? -Method
	#epatch ${FILESDIR}/${P}-configure.patch
	use flexresp && epatch ${FILESDIR}/2.1.2-libnet-1.0.patch

	epatch ${FILESDIR}/${P}-gcc3.patch

	#epatch ${FILESDIR}/snort-drop-calculation.diff

	sed -i "s:var RULE_PATH ../rules:var RULE_PATH /etc/snort:" etc/snort.conf

	# Prelude patch currently not compatible with 2.1.0
	#use prelude && (
	#	epatch ../${P/.1.0/.0.2}-prelude.diff
	#	sh ./autogen.sh
	#)

	use snortsam && (
		cd ..
		./patchsnort.sh ${S}
		cd ${S}
	)
}

src_compile() {
	local myconf
	use flexresp && myconf="$myconf --enable-flexresp" # There is no --diable-flexresp, can't use use_enable
#	use samba && myconf="$myconf --enable-smbalerts" # There is no --diable-smbalerts, can't use use_enable

#		`use_with snmp` \
#		 --enable-pthreads \ # Not supported, never was, and now also removed
#		`use_with prelude` \

	econf \
		`use_with postgres postgresql` \
		`use_with mysql` \
		`use_with ssl openssl` \
		--without-odbc \
		--without-oracle \
		$myconf || die "bad ./configure"

	emake || die "compile problem"
}

pkg_preinst() {
	enewgroup snort
	enewuser snort -1 /dev/null /var/log/snort snort
	usermod -d "/var/log/snort" snort || die "usermod problem"
	usermod -g "snort" snort || die "usermod problem"
	usermod -s "/dev/null" snort || die "usermod problem"
	echo "ignore any message about CREATE_HOME above..."
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
	doins etc/reference.config etc/classification.config rules/*.rules etc/*.map etc/threshold.conf
	#use prelude && doins etc/prelude-classification.config
	newins etc/snort.conf snort.conf.distrib

	exeinto /etc/init.d ; newexe ${FILESDIR}/snort.rc6 snort
	insinto /etc/conf.d ; newins ${FILESDIR}/snort.confd snort

	chown snort:snort ${D}/var/log/snort
	chmod 0770 ${D}/var/log/snort
}

pkg_postinst() {
	if use mysql || use postgres
	then
		einfo "To use a database as a backend for snort you'll have to"
		einfo "import the correct tables to the database."
		einfo "You'll have to setup a user called snort first."
		einfo ""
		use mysql && einfo "  MySQL: zcat /usr/share/doc/${P}/contrib/create_mysql.gz | mysql -p snort"
		use postgres && einfo "  PostgreSQL: import /usr/share/doc/${P}/contrib/create_postgresql.gz"
		einfo ""
		einfo "Also, read the following Gentoo forums article:"
		einfo '   http://forums.gentoo.org/viewtopic.php?t=78718'
	fi
}
