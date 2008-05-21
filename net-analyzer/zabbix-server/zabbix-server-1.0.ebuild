# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-server/zabbix-server-1.0.ebuild,v 1.7 2008/05/21 18:52:04 dev-zero Exp $

inherit eutils

MY_P=${PN//-server/}
DESCRIPTION="ZABBIX is software for monitoring of your applications, network and servers. Server part."

HOMEPAGE="http://zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="snmp mysql postgres"

DEPEND="snmp? ( net-analyzer/net-snmp )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:"
RDEPEND="net-analyzer/fping"

S=${WORKDIR}/${MY_P}-${PV}

pkg_setup() {
	enewgroup zabbix
	enewuser zabbix -1 -1 /dev/null zabbix
}

src_unpack() {
	if ( use mysql && use postgres )
	then
	eerror "You can't use both database in zabbix. Select one database"
	die "Set both database"
	fi
	if (( ! use mysql ) && ( ! use postgres ))
	then
	eerror "Selected mysql or postgresql database"
	die "No select database"
	fi
	unpack ${A}
}

src_compile() {
	local myconf=""
	if use mysql; then
		myconf="--with-mysql"
		einfo "using mysql backend"
	fi
	if use postgres; then
		myconf="--with-pgsql"
		einfo "using postgresql backend"
	fi
	if use snmp; then
		myconf="${myconf} --with-net-snmp"
		einfo "using net-snmp for snmp request"
	fi
	./configure ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /etc/zabbix /var/log/zabbix /var/run/zabbix /usr/share/zabbix/sripts /usr/share/zabbix/dbms
	keepdir /etc/zabbix /var/log/zabbix /var/run/zabbix
	insinto /etc/zabbix
	doins ${FILESDIR}/${PV}/zabbix_suckerd.conf ${FILESDIR}/${PV}/zabbix_trapper.conf ${FILESDIR}/${PV}/zabbix_trapperd.conf
	doconfd ${FILESDIR}/${PV}/conf.d/zabbix-suckerd ${FILESDIR}/${PV}/conf.d/zabbix-trapperd
	doinitd ${FILESDIR}/${PV}/init.d/zabbix-suckerd ${FILESDIR}/${PV}/init.d/zabbix-trapperd
	fowners zabbix:zabbix /etc/zabbix /var/log/zabbix /var/run/zabbix /usr/share/zabbix/sripts /usr/share/zabbix/dbms /etc/zabbix/zabbix_suckerd.conf /etc/zabbix/zabbix_trapper.conf /etc/zabbix/zabbix_trapperd.conf
	fperms 0640 /etc/zabbix/zabbix_suckerd.conf /etc/zabbix/zabbix_trapper.conf /etc/zabbix/zabbix_trapperd.conf
	dosbin bin/zabbix_suckerd bin/zabbix_trapper bin/zabbix_trapperd
	fperms 0750 /var/log/zabbix /var/run/zabbix
	dodoc README INSTALL NEWS ChangeLog
	insinto /usr/share/doc/${P}
	doins doc/Zabbix\ Manual.pdf
	insinto /usr/share/zabbix/dbms
	doins create/data/data.sql
	if use mysql; then
		doins create/mysql/schema.sql
	fi
	if use postgres; then
		doins create/postgresql/schema.sql
	fi
}

pkg_postinst(){
	if ( use mysql ); then
		elog "You need configure mysql for zabbix."
		elog "For more info read Zabbix Manual (/usr/share/doc/${P}/Zabbix Manual.pdf)"
	fi
	if ( use postgres ); then
		elog "You need configure postgresql for zabbix."
		elog "For more info read Zabbix Manual (/usr/share/doc/${P}/Zabbix Manual.pdf)"
	fi

}
