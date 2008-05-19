# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dspam/dspam-3.8.0-r9.ebuild,v 1.4 2008/05/19 20:03:26 dev-zero Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools flag-o-matic multilib

DESCRIPTION="A statistical-algorithmic hybrid anti-spam filter"
HOMEPAGE="http://dspam.nuclearelephant.com/"
SRC_URI="http://dspam.nuclearelephant.com/sources/${P}.tar.gz
	mirror://gentoo/${P}-patches-20071231.tar.gz
	http://dspam.nuclearelephant.com/sources/extras/dspam_sa_trainer.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="clamav daemon debug ldap mysql postgres sqlite syslog \
	large-domain virtual-users user-homedirs"

COMMON_DEPEND="clamav?		( >=app-antivirus/clamav-0.90.2 )
	ldap?		( >=net-nds/openldap-2.2 )
	mysql?		( virtual/mysql )
	sqlite?		( =dev-db/sqlite-3* )"
DEPEND="${COMMON_DEPEND}
	postgres?	( >=virtual/postgresql-base-8 )"
RDEPEND="${COMMON_DEPEND}
	postgres?	( || ( dev-python/psycopg >=dev-db/postgresql-8 ) )
	sys-process/cronbase
	virtual/logger"

# some FHS-like structure
DSPAM_HOMEDIR="/var/spool/dspam"
DSPAM_CONFDIR="/etc/mail/dspam"
DSPAM_LOGDIR="/var/log/dspam"
DSPAM_MODE=2511

pkg_setup() {
	# Delete these lines some time after -r6 removal
	if has_version "<=mail-filter/dspam-3.8.0-r6" &&
		built_with_use "<=mail-filter/dspam-3.8.0-r6" sqlite &&
		grep -q "^StorageDriver.*libsqlite_drv.so" "${ROOT}${DSPAM_CONFDIR}"/dspam.conf; then
			eerror "Sqlite2 support has been removed. Please upgrade your database to sqlite3"
			eerror "and select libsqlite3_drv.so in dspam.conf before proceeding with update."
			die "sqlite-2 no longer supported"
	fi

	local egid euid
	# Need a UID and GID >= 1000, for being able to use suexec in apache
	for euid in $(seq 1000 5000 ) ; do
		[[ -z $(egetent passwd ${euid}) ]] && break
	done
	for egid in $(seq 1000 5000 ) ; do
		[[ -z $(egetent group ${egid}) ]] && break
	done

	enewgroup dspam ${egid}
	enewuser dspam ${euid} -1 "${DSPAM_HOMEDIR}" dspam,mail
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch"
	epatch "${WORKDIR}"/patches

	# Fix Lazy bindings
	append-flags $(bindnow-flags)

	AT_M4DIR="${S}/m4"
	eautoreconf
}

src_compile() {
	local myconf=""

	if use mysql || use postgres; then
		myconf="${myconf} $(use_enable virtual-users) --enable-preferences-extension"
		if use virtual-users; then
			myconf="${myconf} --disable-homedir"
			use user-homedirs && ewarn "user-homedirs support has been disabled (not compatible with --enable-virtual-users)"
		else
			myconf="${myconf} $(use_enable user-homedirs homedir)"
		fi
	else
		myconf="${myconf} --disable-virtual-users --disable-preferences-extension \
			 $(use_enable user-homedirs homedir)"
		use virtual-users && ewarn "virtual-users support has been disabled (available only for mysql and postgres storage drivers)"
	fi

	local STORAGE="hash_drv"
	# select storage driver
	if use sqlite ; then
		STORAGE="${STORAGE},sqlite3_drv"
	fi
	if use mysql; then
		STORAGE="${STORAGE},mysql_drv"
		myconf="${myconf} --with-mysql-includes=/usr/include/mysql"
		myconf="${myconf} --with-mysql-libraries=/usr/$(get_libdir)/mysql"
	fi
	if use postgres ; then
		STORAGE="${STORAGE},pgsql_drv"
		myconf="${myconf} --with-pgsql-includes=/usr/include/postgresql"
		myconf="${myconf} --with-pgsql-libraries=/usr/$(get_libdir)/postgresql"
	fi

	econf --with-storage-driver=${STORAGE} \
			--with-dspam-home="${DSPAM_HOMEDIR}" \
			--sysconfdir="${DSPAM_CONFDIR}" \
			$(use_enable daemon) \
			$(use_enable ldap) \
			$(use_enable clamav) \
			$(use_enable large-domain large-scale) \
			$(use_enable !large-domain domain-scale) \
			$(use_enable syslog) \
			$(use_enable debug) \
			$(use_enable debug bnr-debug) \
			$(use_enable debug verbose-debug) \
			--enable-long-usernames \
			--with-dspam-group=dspam \
			--with-dspam-home-group=dspam \
			--with-dspam-mode=${DSPAM_MODE} \
			--with-logdir="${DSPAM_LOGDIR}" \
			${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	diropts -m0770 -o dspam -g dspam
	dodir "${DSPAM_CONFDIR}"
	insinto "${DSPAM_CONFDIR}"
	insopts -m640 -o dspam -g dspam
	doins src/dspam.conf
	dosym /etc/mail/dspam /etc/dspam

	# make install
	emake DESTDIR="${D}" install || die "emake install failed"

	# necessary for dovecot-dspam
	insopts -m644
	insinto /usr/include/dspam && doins src/pref.h

	diropts -m0755 -o dspam -g dspam
	dodir /var/run/dspam

	# create logdir (used only when syslog support has been disabled or build with --enable-debug)
	if ! use syslog || use debug ; then
		diropts -m0770 -o dspam -g dspam
		dodir "${DSPAM_LOGDIR}"
		diropts -m0755
		insinto /etc/logrotate.d
		newins "${FILESDIR}/logrotate.dspam" dspam || die "failed to install logrotate.d file"
	fi

	if use daemon; then
		# We use sockets for the daemon instead of tcp port 24
		sed -e 's:^#*\(ServerDomainSocketPath[\t ]\{1,\}\).*:\1\"/var/run/dspam/dspam.sock\":gI' \
			-e 's:^#*\(ServerPID[\t ]\{1,\}\).*:\1/var/run/dspam/dspam.pid:gI' \
			-e 's:^#*\(ClientHost[\t ]\{1,\}\)/.*:\1\"/var/run/dspam/dspam.sock\":gI' \
			-i "${D}/${DSPAM_CONFDIR}/dspam.conf"

		newinitd "${FILESDIR}/dspam.rc" dspam || die "failed to install init script"

		fowners root:dspam /usr/bin/dspamc &&
			fperms u=rx,g=xs,o=x /usr/bin/dspamc ||
			die "failed to alter dspamc owner:group or mode"
	fi

	# database related configuration and scripts
	local PASSWORD="${RANDOM}${RANDOM}${RANDOM}${RANDOM}" DSPAM_DB_DATA=()
	if use sqlite; then
		insinto "${DSPAM_CONFDIR}"
		newins src/tools.sqlite_drv/purge-3.sql sqlite3_purge.sql || die "failed to install sqlite3_purge.sql script"
	fi
	if use mysql; then
		DSPAM_DB_DATA[0]="/var/run/mysqld/mysqld.sock"
		DSPAM_DB_DATA[1]=""
		DSPAM_DB_DATA[2]="dspam"
		DSPAM_DB_DATA[3]="${PASSWORD}"
		DSPAM_DB_DATA[4]="dspam"
		DSPAM_DB_DATA[5]="false"

		# Activate mysql database configuration
		sed -e "s:^#*\(MySQLServer[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[0]}:gI" \
			-e "s:^#*\(MySQLPort[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[1]}:gI" \
			-e "s:^#*\(MySQLUser[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[2]}:gI" \
			-e "s:^#*\(MySQLPass[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[3]}:gI" \
			-e "s:^#*\(MySQLDb[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[4]}:gI" \
			-e "s:^#*\(MySQLCompress[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[5]}:gI" \
			-i "${D}/${DSPAM_CONFDIR}/dspam.conf"

		insinto "${DSPAM_CONFDIR}"
		newins src/tools.mysql_drv/mysql_objects-space.sql mysql_objects-space.sql &&
			newins src/tools.mysql_drv/mysql_objects-speed.sql mysql_objects-speed.sql &&
			newins src/tools.mysql_drv/mysql_objects-4.1.sql mysql_objects-4.1.sql &&
			newins src/tools.mysql_drv/purge.sql mysql_purge.sql &&
			newins src/tools.mysql_drv/purge-4.1.sql mysql_purge-4.1.sql ||
			die "failed to install mysql*.sql scripts"
		if use virtual-users ; then
			newins src/tools.mysql_drv/virtual_users.sql mysql_virtual_users.sql &&
				newins src/tools.mysql_drv/virtual_user_aliases.sql mysql_virtual_user_aliases.sql ||
				die "failed to install mysql_virtual_user*.sql scripts"
		fi
	fi
	if use postgres ; then
		DSPAM_DB_DATA[0]="127.0.0.1"
		DSPAM_DB_DATA[1]="5432"
		DSPAM_DB_DATA[2]="dspam"
		DSPAM_DB_DATA[3]="${PASSWORD}"
		DSPAM_DB_DATA[4]="dspam"

		# Activate pgsql database configuration
		sed -e "s:^#*\(PgSQLServer[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[0]}:gI" \
			-e "s:^#*\(PgSQLPort[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[1]}:gI" \
			-e "s:^#*\(PgSQLUser[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[2]}:gI" \
			-e "s:^#*\(PgSQLPass[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[3]}:gI" \
			-e "s:^#*\(PgSQLDb[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[4]}:gI" \
			-e "s:^#*\(PgSQLConnectionCache[\t ]*.\):\1:gI" \
			-i "${D}/${DSPAM_CONFDIR}"/dspam.conf

		insinto "${DSPAM_CONFDIR}"
		newins src/tools.pgsql_drv/pgsql_objects.sql pgsql_objects.sql &&
			newins src/tools.pgsql_drv/purge.sql pgsql_purge.sql ||
			die "failed to install pgsql*.sql scripts"
		if use virtual-users ; then
			newins src/tools.pgsql_drv/virtual_users.sql pgsql_virtual_users.sql ||
				die "failed to install pgsql_virtual_users.sql scripts"
		fi

		# Install psycopg scripts needed when postgresql is not installed
		exeinto "${DSPAM_CONFDIR}"
		doexe "${FILESDIR}"/pgsql_{createdb,purge}.py || die "failed to install psycopg scripts"
	fi

	# Set default storage
	local DEFAULT_STORAGE
	if use sqlite ; then
		DEFAULT_STORAGE=sqlite3
	elif use mysql ; then
		DEFAULT_STORAGE=mysql
	elif use postgres ; then
		DEFAULT_STORAGE=pgsql
	fi
	if [[ -z "${DEFAULT_STORAGE}" ]]; then
		# When only one storage driver is compiled, it is linked statically with dspam
		# thus you should not set the StorageDriver at all
		# Also, hash_drv requires certain tokenizer and PValue (see bug #185718)
		sed -e "s:^\(StorageDriver[\t ].*\)$:#\1:" \
			-e "s:^Tokenizer .*$:Tokenizer sbph:" \
			-e "/^#PValue/d" \
			-e "s:^PValue .*$:PValue markov:" \
			-i "${D}/${DSPAM_CONFDIR}"/dspam.conf
	else
		# Set the storage driver and use purge configuration for SQL-based installations
		sed -e "s:^\(Purge.*\):###\1:g" \
			-e "s:^#\(Purge.*\):\1:g" \
			-e "s:^###\(Purge.*\):#\1:g" \
			-e "s:^\(StorageDriver[\t ].*\)libhash_drv.so:\1lib${DEFAULT_STORAGE}_drv.so:" \
			-i "${D}/${DSPAM_CONFDIR}"/dspam.conf
	fi

	# installs the notification messages
	# -> The documentation is wrong! The files need to be in ./txt
	echo "Scanned and tagged as SPAM with DSPAM ${PV} by Your ISP.com">"${T}"/msgtag.spam
	echo "Scanned and tagged as non-SPAM with DSPAM ${PV} by Your ISP.com">"${T}"/msgtag.nonspam
	insinto "${DSPAM_CONFDIR}"/txt
	doins "${S}"/txt/*.txt
	doins "${T}"/msgtag.*

	# Create the opt-in / opt-out directories
	diropts -m0770 -o dspam -g dspam
	dodir "${DSPAM_HOMEDIR}"
	keepdir "${DSPAM_HOMEDIR}"/opt-in
	keepdir "${DSPAM_HOMEDIR}"/opt-out
	diropts -m0755

	# dspam cron job
	exeinto /etc/cron.daily
	newexe "${FILESDIR}/dspam.cron-r1" dspam.cron || die "failed to install cron script"

	# documentation
	dodoc CHANGELOG README* RELEASE.NOTES UPGRADING
	docinto doc
	dodoc doc/*.txt
	docinto gentoo
	dodoc "${FILESDIR}"/README.{postfix,qmail}
	docinto sa_train
	dodoc "${WORKDIR}"/dspam_sa_trainer/*
	doman man/dspam*
}

pkg_preinst() {
	# Delete these lines some time after -r6 removal
	if has_version "<=mail-filter/dspam-3.8.0-r6" ; then
		# Remove obsolete *.data files
		local f
		for f in "${ROOT}${DSPAM_CONFDIR}"/{mysql,pgsql}.data ; do
			f=${f/\/\//\/}
			if [[ -f "${f}" ]]; then
				rm "${f}" &&
					elog "Obsolete ${f} has been removed" ||
					eerror "Failed to remove ${f}"
			fi
		done
	fi
}

pkg_postinst() {
	ewarn "The hash_drv storage backend has the following requirements:"
	ewarn "  - PValue must be set to 'markov'; Do not use this pvalue with any other storage backend!"
	ewarn "  - Tokenizer must be either 'sbph' or 'osb'"
	ewarn "See markov.txt for more info."

	if use mysql || use postgres; then
		elog
		elog "To setup DSPAM to run out-of-the-box on your system with a MySQL"
		elog "or PostgreSQL database, run:"
		elog "emerge --config =${PF}"
	fi

	if use daemon; then
		elog
		elog "If you want to run DSPAM in the new daemon mode remember"
		elog "to make the DSPAM daemon start during boot:"
		elog "  rc-update add dspam default"
		elog
		elog "To use the DSPAM daemon mode, the used storage driver must be thread-safe."
	fi

	elog
	elog "See http://dspamwiki.expass.de/Installation for more info"
}

# Edits interactively one or more parameters from "${ROOT}${DSPAM_CONFDIR}/dspam.conf"
# Usage: edit_dspam_params param_name1 [param_name2 ..]
edit_dspam_params() {
	local PARAMETER OLD_VALUE VALUE
	for PARAMETER in $@ ; do
		OLD_VALUE=$(awk "BEGIN { IGNORECASE=1; } \$1==\"${PARAMETER}\" { print \$2; exit; }" "${ROOT}${DSPAM_CONFDIR}/dspam.conf")
		[[ $? == 0 ]] || return 1
		if [[ "${PARAMETER}" == *"Pass" ]]; then
			read -r -p "${PARAMETER} (default ${OLD_VALUE:-none}; enter random for generating a new random password): " VALUE
			[[ "${VALUE}" == "random" ]] && VALUE="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
		else
			read -r -p "${PARAMETER} (default ${OLD_VALUE:-none}): " VALUE
		fi

		if [[ -z "${VALUE}" ]] ; then
			VALUE=${OLD_VALUE}
		else
			sed -e "s:^#*${PARAMETER}\([\t ].*\)\?\$:${PARAMETER} ${VALUE}:gI" \
				-i "${ROOT}${DSPAM_CONFDIR}/dspam.conf"
			[[ $? == 0 ]] || return 2
		fi
		eval $PARAMETER=\"${VALUE}\"
	done
	return 0
}

# Selects the storage driver in "${ROOT}${DSPAM_CONFDIR}/dspam.conf"
# usage: set_storage_driver { hash | sqlite3 | mysql | pgsql }
set_storage_driver() {
	sed	-e "s:^[#\t ]*\(StorageDriver[\t ].*\)lib[a-z1-9]\+_drv.so:\1lib${1}_drv.so:" \
		-i "${ROOT}${DSPAM_CONFDIR}"/dspam.conf &&
		einfo "Storage driver lib${1}_drv.so has been selected"
}

pkg_config () {
	local AVAIL_BACKENDS=( hash )
	use sqlite && AVAIL_BACKENDS=( ${AVAIL_BACKENDS[*]} sqlite )
	use mysql && AVAIL_BACKENDS=( ${AVAIL_BACKENDS[*]} mysql )
	use postgres && AVAIL_BACKENDS=( ${AVAIL_BACKENDS[*]} postgres )
	local USE_BACKEND
	read -p "Which backend do you want to configure? (available backends are ${AVAIL_BACKENDS[*]}): " USE_BACKEND
	if [[ " ${AVAIL_BACKENDS[*]} " != *" ${USE_BACKEND} "* ]]; then
		eerror "The '${USE_BACKEND}' backend is not available."
		return 1
	fi

	case "${USE_BACKEND}" in

		hash)
			einfo "hash driver will automatically create the necessary databases"
			set_storage_driver hash
			;;

		sqlite)
			einfo "sqlite driver will automatically create the necessary databases"
			set_storage_driver sqlite3
			;;

		mysql)
			local MySQLServer MySQLPort MySQLUser MySQLPass MySQLDb MySQLCompress
			edit_dspam_params MySQLServer MySQLPort MySQLUser MySQLPass MySQLDb MySQLCompress || return $?
			if [[ -z "${MySQLServer}" || -z "${MySQLUser}" || -z "${MySQLPass}" || -z "${MySQLDb}" ]]; then
				eerror "Following parameters are required: MySQLServer MySQLUser MySQLPass MySQLDb"
				return 1
			fi

			local MySQL_DB_Type MySQL_Virtuser_Type
			einfo "  Please select what kind of database you like to create:"
			einfo "    [0] Don't create the database, I will do it myself"
			einfo "    [1] Database will be hosted on a mysql-4.1 server or above"
			einfo "    [2] Space optimized database on a mysql-4.0 server or below"
			einfo "    [3] Speed optimized database on a mysql-4.0 server or below"
			einfo
			while read -n 1 -s -p "  Press 0, 1, 2 or 3 on the keyboard to select database " MySQL_DB_Type; do
				if [[ "${MySQL_DB_Type}" == "0" ]] ; then
					echo
					set_storage_driver mysql
					return 0
				fi
				[[ "${MySQL_DB_Type}" == "1" || "${MySQL_DB_Type}" == "2" || "${MySQL_DB_Type}" == "3" ]] && echo && break
			done
			if use virtual-users ; then
				einfo "  Please select what kind of virtual_uids table you like to use:"
				einfo "    [1] Virtual users added automatically (use it if this server is the primary MX)"
				einfo "    [2] Virtual users added manually (use it if this server is a secondary MX)"
				einfo
				while read -n 1 -s -p "  Press 1 or 2 on the keyboard to select table type " MySQL_Virtuser_Type; do
					[[ "${MySQL_Virtuser_Type}" == "1" || "${MySQL_Virtuser_Type}" == "2" ]] && echo && break
				done
			fi

			local MYSQL_ROOT_USER
			read -r -p "Your administrative MySQL account (default root): " MYSQL_ROOT_USER
			if [[ -z "${MYSQL_ROOT_USER}" ]]; then
				MYSQL_ROOT_USER="root"
			fi
			einfo "When prompted for a password, please enter your MySQL ${MYSQL_ROOT_USER} password"

			local MYSQL_CMD_LINE="/usr/bin/mysql -u ${MYSQL_ROOT_USER} -p"
			[[ "${MySQLServer}" != "/"* ]] && MYSQL_CMD_LINE="${MYSQL_CMD_LINE} -h ${MySQLServer}"
			[[ -n "${MySQLPort}" ]] && MYSQL_CMD_LINE="${MYSQL_CMD_LINE} -P ${MySQLPort}"
			{
				echo "CREATE DATABASE ${MySQLDb};"
				echo "USE ${MySQLDb};"
				case ${MySQL_DB_Type} in
					1) cat "${ROOT}${DSPAM_CONFDIR}"/mysql_objects-4.1.sql ;;
					2) cat "${ROOT}${DSPAM_CONFDIR}"/mysql_objects-space.sql ;;
					3) cat "${ROOT}${DSPAM_CONFDIR}"/mysql_objects-speed.sql ;;
				esac
				if use virtual-users ; then
					case ${MySQL_Virtuser_Type} in
						1) cat "${ROOT}${DSPAM_CONFDIR}"/mysql_virtual_users.sql ;;
						2) cat "${ROOT}${DSPAM_CONFDIR}"/mysql_virtual_user_aliases.sql ;;
					esac
				fi
				echo "GRANT SELECT,INSERT,UPDATE,DELETE ON ${MySQLDb}.* TO '${MySQLUser}'@'%' IDENTIFIED BY '${MySQLPass}';"
				echo "FLUSH PRIVILEGES;"
			} | ${MYSQL_CMD_LINE}
			[[ ${PIPESTATUS[1]} == 0 ]] || return ${PIPESTATUS[1]}

			einfo "MySQL database created successfully"
			set_storage_driver mysql
			;;

		postgres)
			local PgSQLServer PgSQLPort PgSQLUser PgSQLPass PgSQLDb
			edit_dspam_params PgSQLServer PgSQLPort PgSQLUser PgSQLPass PgSQLDb || return $?
			if [[ -z "${PgSQLServer}" || -z "${PgSQLUser}" || -z "${PgSQLPass}" || -z "${PgSQLDb}" ]]; then
				eerror "Following parameters are required: PgSQLServer PgSQLUser PgSQLPass PgSQLDb"
				return 1
			fi

			local PgSQL_DB_Create
			einfo "  Do you want PgSQL database be automatically created for you?"
			while read -n 1 -s -p "  Press y or n " PgSQL_DB_Create; do
				if [[ "${PgSQL_DB_Create}" == "n" || "${PgSQL_DB_Create}" == "N" ]] ; then
					echo
					set_storage_driver pgsql
					return 0
				fi
				[[ "${PgSQL_DB_Create}" == "y" || "${PgSQL_DB_Create}" == "Y" ]] && echo && break
			done

			local PGSQL_ROOT_USER
			read -r -p "Your administrative PgSQL account (default postgres): " PGSQL_ROOT_USER
			if [[ -z "${PGSQL_ROOT_USER}" ]]; then
				PGSQL_ROOT_USER="postgres"
			fi
			einfo "When prompted for a password, please enter your PgSQL ${PGSQL_ROOT_USER} password"

			if [[ -x /usr/bin/psql ]]; then
				# Create database using psql
				local PGSQL_CMD_LINE="/usr/bin/psql -h ${PgSQLServer}"
				[[ -n "${PgSQLPort}" ]] && PGSQL_CMD_LINE="${PGSQL_CMD_LINE} -p ${PgSQLPort}"

				{
					echo "\\set ON_ERROR_STOP = on;"
					echo "CREATE USER ${PgSQLUser} WITH PASSWORD '${PgSQLPass}' NOCREATEDB NOCREATEUSER;"
					echo "CREATE DATABASE ${PgSQLDb};"
					echo "GRANT ALL PRIVILEGES ON DATABASE ${PgSQLDb} TO ${PgSQLUser};"
					echo "GRANT ALL PRIVILEGES ON SCHEMA public TO ${PgSQLUser};"
					echo "UPDATE pg_database SET datdba=(SELECT usesysid FROM pg_shadow WHERE usename='${PgSQLUser}') WHERE datname='${PgSQLDb}';"
					echo "\\c ${PgSQLDb};"
					echo "CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler AS '\$libdir/plpgsql', 'plpgsql_call_handler' LANGUAGE c;"
					echo "CREATE FUNCTION plpgsql_validator(oid) RETURNS void AS '\$libdir/plpgsql', 'plpgsql_validator' LANGUAGE c;"
					echo "CREATE TRUSTED PROCEDURAL LANGUAGE plpgsql HANDLER plpgsql_call_handler VALIDATOR plpgsql_validator;"
				} | ${PGSQL_CMD_LINE} -d template1 -U ${PGSQL_ROOT_USER}
				[[ ${PIPESTATUS[1]} == 0 ]] || return ${PIPESTATUS[1]}

				{
					echo "\\set ON_ERROR_STOP = on;"
					cat "${ROOT}${DSPAM_CONFDIR}"/pgsql_objects.sql
					use virtual-users && cat "${ROOT}${DSPAM_CONFDIR}"/pgsql_virtual_users.sql
				} | PGUSER="${PgSQLUser}" PGPASSWORD="${PgSQLPass}" ${PGSQL_CMD_LINE} -d "${PgSQLDb}" -U ${PgSQLUser}
				[[ ${PIPESTATUS[1]} == 0 ]] || return ${PIPESTATUS[1]}
			else
				# Create database using psycopg script
				if use virtual-users ; then
					DSPAM_PgSQLPass="${PgSQLPass}" "${ROOT}${DSPAM_CONFDIR}"/pgsql_createdb.py "${PgSQLServer}" "${PgSQLPort}" "${PGSQL_ROOT_USER}" \
						"${PgSQLUser}" "${PgSQLDb}" "${ROOT}${DSPAM_CONFDIR}"/pgsql_objects.sql "${ROOT}${DSPAM_CONFDIR}"/pgsql_virtual_users.sql
				else
					DSPAM_PgSQLPass="${PgSQLPass}" "${ROOT}${DSPAM_CONFDIR}"/pgsql_createdb.py "${PgSQLServer}" "${PgSQLPort}" "${PGSQL_ROOT_USER}" \
						"${PgSQLUser}" "${PgSQLDb}" "${ROOT}${DSPAM_CONFDIR}"/pgsql_objects.sql
				fi
				[[ $? == 0 ]] || return $?
			fi

			einfo "PgSQL database created successfully"
			set_storage_driver pgsql
			;;

	esac
}
