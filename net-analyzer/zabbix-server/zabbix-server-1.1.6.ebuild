# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-server/zabbix-server-1.1.6.ebuild,v 1.1 2007/02/11 22:29:06 wschlich Exp $

inherit eutils

MY_P=${PN//-server/}
MY_PV=${PV//_/}
DESCRIPTION="ZABBIX is software for monitoring of your applications, network and servers. Server part."
HOMEPAGE="http://www.zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ldap mysql oracle postgres snmp"
DEPEND="virtual/libc
	snmp? ( net-analyzer/net-snmp )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )"
RDEPEND="${RDEPEND} net-analyzer/fping"

S=${WORKDIR}/${MY_P}-${MY_PV}

pkg_setup() {
	if useq oracle; then
		if [ -z "${ORACLE_HOME}" ]; then
			eerror
			eerror "The environment variable ORACLE_HOME must be set"
			eerror "and point to the correct location."
			eerror "It looks like you don't have Oracle installed."
			eerror
			die "Environment variable ORACLE_HOME is not set"
		fi
		if has_version 'dev-db/oracle-instantclient-basic'; then
			ewarn
			ewarn "Please ensure you have a full install of the Oracle client."
			ewarn "dev-db/oracle-instantclient* is NOT sufficient."
			ewarn
		fi
	fi
}

pkg_preinst() {
	enewgroup zabbix
	enewuser zabbix -1 -1 /var/lib/zabbix/home zabbix
}

pkg_postinst() {
	einfo
	einfo "You need to configure your database for Zabbix."
	einfo
	einfo "Have a look at /usr/share/zabbix/database for"
	einfo "database creation and upgrades."
	einfo
	einfo "For more info read the Zabbix manual at"
	einfo "http://www.zabbix.com/manual/v1.1/"
	einfo

	zabbix_homedir="$(egetent passwd zabbix | cut -d : -f 6 )"
	if [ -n "${zabbix_homedir}" ] && \
	   [ "${zabbix_homedir}" != "/var/lib/zabbix/home" ]; then
		ewarn
		ewarn "The user 'zabbix' should have his homedir changed"
		ewarn "to /var/lib/zabbix/home if you want to use"
		ewarn "custom alert scripts."
		ewarn
		ewarn "A real homedir might be needed for configfiles"
		ewarn "for custom alert scripts (e.g. ~/.sendxmpprc when"
		ewarn "using sendxmpp for Jabber alerts)."
		ewarn
		ewarn "To change the homedir use:"
		ewarn "  usermod -d /var/lib/zabbix/home zabbix"
		ewarn
	fi
}

src_unpack() {
	local dbnum dbtypes="mysql postgres oracle" dbtype
	declare -i dbnum=0
	for dbtype in ${dbtypes}; do
		useq ${dbtype} && let dbnum++
	done
	if [ ${dbnum} -gt 1 ]; then
		eerror
		eerror "You can't use more than one database type in Zabbix."
		eerror "Select exactly one database type out of these: ${dbtypes}"
		eerror
		die "Multiple database types selected."
	elif [ ${dbnum} -lt 1 ]; then
		eerror
		eerror "Select exactly one database type out of these: ${dbtypes}"
		eerror
		die "No database type selected."
	fi
	unpack ${A}
}

src_compile() {
	econf \
		--enable-server \
		$(use_with ldap) \
		$(use_with snmp net-snmp) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		$(use_with oracle) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir \
		/etc/zabbix \
		/var/lib/zabbix \
		/var/lib/zabbix/home \
		/var/lib/zabbix/scripts \
		/var/log/zabbix \
		/var/run/zabbix \
		/usr/share/zabbix/database

	keepdir \
		/etc/zabbix \
		/var/lib/zabbix \
		/var/lib/zabbix/home \
		/var/lib/zabbix/scripts \
		/var/log/zabbix \
		/var/run/zabbix

	insinto /etc/zabbix
	doins ${FILESDIR}/${PV}/zabbix_server.conf

	doinitd ${FILESDIR}/${PV}/init.d/zabbix-server

	fowners zabbix:zabbix \
		/etc/zabbix \
		/etc/zabbix/zabbix_server.conf \
		/usr/share/zabbix/database \
		/var/lib/zabbix \
		/var/lib/zabbix/home \
		/var/lib/zabbix/scripts \
		/var/log/zabbix \
		/var/run/zabbix
	fperms 0640 \
		/etc/zabbix/zabbix_server.conf
	fperms 0750 \
		/etc/zabbix \
		/var/lib/zabbix \
		/var/lib/zabbix/home \
		/var/lib/zabbix/scripts \
		/var/log/zabbix \
		/var/run/zabbix

	dosbin src/zabbix_server/zabbix_server

	insinto /usr/share/zabbix/database
	doins -r upgrades create

	dodoc README INSTALL NEWS ChangeLog
}
