# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-server/zabbix-server-1.1.7.ebuild,v 1.3 2008/05/19 20:15:37 dev-zero Exp $

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
	postgres? ( virtual/postgresql-base )"
RDEPEND="${RDEPEND} net-analyzer/fping"

S=${WORKDIR}/${MY_P}-${MY_PV}

pkg_setup() {
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

	enewgroup zabbix
	enewuser zabbix -1 -1 /var/lib/zabbix/home zabbix
}

pkg_postinst() {
	elog
	elog "You need to configure your database for Zabbix."
	elog
	elog "Have a look at /usr/share/zabbix/database for"
	elog "database creation and upgrades."
	elog
	elog "For more info read the Zabbix manual at"
	elog "http://www.zabbix.com/manual/v1.1/"
	elog

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

	# repeat fowners/fperms functionality from src_install()
	# here to catch wrong permissions on existing files in
	# the live filesystem (yeah, that sucks).
	chown zabbix:zabbix \
		${ROOT}etc/zabbix \
		${ROOT}etc/zabbix/zabbix_server.conf \
		${ROOT}var/lib/zabbix \
		${ROOT}var/lib/zabbix/home \
		${ROOT}var/lib/zabbix/scripts \
		${ROOT}var/log/zabbix \
		${ROOT}var/run/zabbix
	chmod 0640 \
		${ROOT}etc/zabbix/zabbix_server.conf
	chmod 0750 \
		${ROOT}etc/zabbix \
		${ROOT}var/lib/zabbix \
		${ROOT}var/lib/zabbix/home \
		${ROOT}var/lib/zabbix/scripts \
		${ROOT}var/log/zabbix \
		${ROOT}var/run/zabbix

	# check for fping
	fping_perms=$(stat -c %a /usr/sbin/fping 2>/dev/null)
	case "${fping_perms}" in
		4[157][157][157])
			;;
		*)
			ewarn
			ewarn "If you want to use the checks 'icmpping' and 'icmppingsec',"
			ewarn "you have to make /usr/sbin/fping setuid root and executable"
			ewarn "by everyone. Run the following command to fix it:"
			ewarn
			ewarn "  chmod u=rwsx,g=rx,o=rx /usr/sbin/fping"
			ewarn
			ewarn "Please be aware that this might impose a security risk,"
			ewarn "depending on the code quality of fping."
			ewarn
			ebeep 3
			epause 5
			;;
	esac
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
