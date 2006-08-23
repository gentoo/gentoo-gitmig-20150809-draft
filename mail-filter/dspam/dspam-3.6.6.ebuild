# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dspam/dspam-3.6.6.ebuild,v 1.4 2006/08/23 03:02:01 weeve Exp $

inherit eutils

DESCRIPTION="A statistical-algorithmic hybrid anti-spam filter"
SRC_URI="http://dspam.nuclearelephant.com/sources/${P}.tar.gz
		http://dspam.nuclearelephant.com/sources/extras/dspam_sa_trainer.tar.gz"
HOMEPAGE="http://dspam.nuclearelephant.com/"
LICENSE="GPL-2"

IUSE="berkdb clamav cyrus daemon debug large-domain ldap logrotate mysql oci8 postgres procmail sqlite sqlite3 virtual-users user-homedirs"

DEPEND="berkdb? ( >=sys-libs/db-4.0 )
	clamav? ( >=app-antivirus/clamav-0.86 )
	ldap? ( >=net-nds/openldap-2.2 )
	daemon? ( || ( mysql? ( >=dev-db/mysql-3.23 ) ) ( postgres? ( >=dev-db/postgresql-7.4.3 ) ) )
	sqlite? ( <dev-db/sqlite-3 )
	sqlite3? ( =dev-db/sqlite-3* )"

RDEPEND="${DEPEND}
	sys-process/cronbase
	cyrus? ( net-mail/cyrus-imapd )
	logrotate? ( app-admin/logrotate )
	procmail? ( mail-filter/procmail )"

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"

# some FHS-like structure
HOMEDIR="/var/spool/dspam"
CONFDIR="/etc/mail/dspam"
LOGDIR="/var/log/dspam"

pkg_setup() {
	local multiple_dbs="0"
	local supported_dbs="berkdb mysql postgres oci8 sqlite sqlite3"
	for foo in ${supported_dbs}; do
		if use ${foo}; then
			let multiple_dbs="((multiple_dbs + 1 ))"
			einfo " ${foo} database support in your USE flags."
		fi
	done

	if [ "${multiple_dbs}" -ge "2" ]; then
		echo
		ewarn "You have multiple database backends active in your USE flags."
		ewarn "The default USE flag will be used in this order"
		ewarn "mysql postgres sqlite sqlite3 oic8 berkdb"
		ewarn "If you want to build with another database backend; hit Control-C now."
		ewarn "Change your USE flag and emerge again."
		echo
		has_version ">=sys-apps/portage-2.0.50" && (
		einfo "It would be best practice to add the set of USE flags that you use for this"
		einfo "package to the file: /etc/portage/package.use. Example:"
		einfo "\`echo \"mail-filter/dspam -mysql -postgres -oci8 -sqlite sqlite3\" >> /etc/portage/package.use\`"
		einfo "to build dspam with a SQLite database as your dspam backend."
		)
	elif [ "${multiple_dbs}" -eq "0" ]; then
		echo
		ewarn "You did not select any SQL based database backend."
		ewarn "DSPAM will use self-contained Hash driver for storing data."
		ewarn "If you don't want that, then enable one of the following"
		ewarn "USE flags: ${supported_dbs}"
	fi

	if use daemon && has_version ">sys-kernel/linux-headers-2.6"; then
		einfo "To use the new DSPAM daemon mode, you need to emerge"
		einfo ">sys-kernel/linux-headers-2.6 and rebuild glibc to support NPTL"
	fi

	if use daemon && ! use mysql && ! use postgres ; then
		echo
		ewarn "To use the new DSPAM daemon mode, you need to emerge either MySQL or PostgreSQL"
	fi

	if use virtual-users && use user-homedirs ; then
		ewarn "If the users are virtual, then they probably should not have home directories."
	fi

	if use user-homedirs ; then
		ewarn "WARNING: dspam-web will not work with user-homedirs.  Disable this USE flag"
		ewarn "if you intend on using dspam-web."
	fi

	id dspam 2>/dev/null || enewgroup dspam 26
	id dspam 2>/dev/null || enewuser dspam 26 /bin/bash ${HOMEDIR} dspam
}

src_compile() {
	local myconf

	myconf="${myconf} --enable-long-username"

	use large-domain && myconf="${myconf} --enable-large-scale" ||\
	    myconf="${myconf} --enable-domain-scale"

	myconf="${myconf} --with-dspam-home=${HOMEDIR}"
	myconf="${myconf} --sysconfdir=${CONFDIR}"
	use user-homedirs && myconf="${myconf} --enable-homedir"
	use clamav && myconf="${myconf} --enable-clamav"
	use ldap && myconf="${myconf} --enable-ldap"

	if use cyrus; then
	    myconf="${myconf} --with-delivery-agent=/usr/lib/cyrus/deliver"
	elif use procmail; then
	    myconf="${myconf} --with-delivery-agent=/usr/bin/procmail"
	fi

	# enables support for debugging (touch /etc/dspam/.debug to turn on)
	# optional: even MORE debugging output, use with extreme caution!
	use debug && myconf="${myconf} --enable-debug --enable-verbose-debug --enable-bnr-debug"

	if use daemon && has_version ">sys-kernel/linux-headers-2.6"; then
	    myconf="${myconf} --enable-daemon"
	fi

	# select storage driver
	if use sqlite ; then
		myconf="${myconf} --with-storage-driver=sqlite_drv"
		myconf="${myconf} --enable-virtual-users"
	elif use sqlite3 ; then
		myconf="${myconf} --with-storage-driver=sqlite3_drv"
		myconf="${myconf} --enable-virtual-users"
	elif use mysql; then
		myconf="${myconf} --with-storage-driver=mysql_drv"
		myconf="${myconf} --with-mysql-includes=/usr/include/mysql"
		myconf="${myconf} --with-mysql-libraries=/usr/lib/mysql"
		myconf="${myconf} --enable-preferences-extension"

		use virtual-users && myconf="${myconf} --enable-virtual-users"
	elif use postgres ; then
		myconf="${myconf} --with-storage-driver=pgsql_drv"
		myconf="${myconf} --with-pgsql-includes=/usr/include/postgresql"
		myconf="${myconf} --with-pgsql-libraries=/usr/lib/postgresql"
		myconf="${myconf} --enable-preferences-extension"

		use virtual-users && myconf="${myconf} --enable-virtual-users"
	elif use sqlite ; then
		myconf="${myconf} --with-storage-driver=sqlite_drv"
		myconf="${myconf} --enable-virtual-users"
	elif use sqlite3 ; then
		myconf="${myconf} --with-storage-driver=sqlite3_drv"
		myconf="${myconf} --enable-virtual-users"
	elif use oci8 ; then
		myconf="${myconf} --with-storage-driver=ora_drv"
		myconf="${myconf} --with-oracle-home=${ORACLE_HOME}"
		myconf="${myconf} --enable-virtual-users"

		# I am in no way a Oracle specialist. If someone knows
		# how to query the version of Oracle, then let me know.
		if (expr ${ORACLE_HOME/*\/} : 10 1>/dev/null 2>&1); then
			myconf="${myconf} --with-oracle-version=10"
		fi
	else
		myconf="${myconf} --with-storage-driver=hash_drv"
	fi

	econf ${myconf} || die
	emake || die
}

src_install () {

	# Fix issues with older dspam configuration
	CONFIG_PROTECT="${CONFIG_PROTECT} ${HOMEDIR} ${CONFDIR} /var/run/dspam"
	CONFIG_PROTECT_MASK="${CONFIG_PROTECTMASK/${HOMEDIR}/}"
	CONFIG_PROTECT_MASK="${CONFIG_PROTECTMASK/${CONFDIR}/}"

	# open up perms on $HOMEDIR
	diropts -m0775 -o dspam -g dspam
	dodir ${HOMEDIR}
	keepdir ${HOMEDIR}

	# keeps dspam data in $CONFDIR
	diropts -m0775 -o dspam -g dspam
	dodir ${CONFDIR}
	keepdir ${CONFDIR}

	# create logdir
	diropts -m0775 -o dspam -g dspam
	dodir ${LOGDIR}
	keepdir ${LOGDIR}

	# make install
	make DESTDIR=${D} install || die
	chmod o+s ${D}/usr/bin/dspam
	chmod o+s ${D}/usr/bin/dspam_stats

	# documentation
	dodoc CHANGELOG LICENSE README* RELEASE.NOTES UPGRADING
	dodoc ${DISTDIR}/dspam_sa_trainer.tar.gz
	docinto doc
	dodoc doc/*.txt
	docinto gentoo
	dodoc ${FILESDIR}/README.postfix ${FILESDIR}/README.qmail
	doman man/dspam*
	dodoc ${DISTDIR}/dspam_sa_trainer.tar.gz

	# build some initial configuration data
	[ ! -f ${CONFDIR}/dspam.conf ] \
		&& cp src/dspam.conf ${T}/dspam.conf

	if use daemon; then
		if has_version ">sys-kernel/linux-headers-2.6"; then
			# keeps dspam socket for daemon in /var/run/dspam
			diropts -m0775 -o dspam -g dspam
			dodir /var/run/dspam
			keepdir /var/run/dspam

			# We use sockets for the daemon instead of tcp port 24
			sed -e 's:^#*\(ServerDomainSocketPath[\t ]\{1,\}\).*:\1\"/var/run/dspam/dspam.sock\":gI' \
				-e 's:^#*\(ServerPID[\t ]\{1,\}\).*:\1/var/run/dspam/dspam.pid:gI' \
				-i ${T}/dspam.conf

			# dspam init script
			exeinto /etc/init.d
			exeopts -m0755 -o root -g root
			newexe ${FILESDIR}/dspam.rc dspam
		fi
	fi

	# generate random password
	local PASSWORD="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"

	# database related configuration and scripts
	if use sqlite; then
		insinto ${CONFDIR}
		insopts -m644 -o dspam -g dspam
		newins src/tools.sqlite_drv/purge-2.sql sqlite_purge.sql
	elif use sqlite3; then
		insinto ${CONFDIR}
		insopts -m644 -o dspam -g dspam
		newins src/tools.sqlite_drv/purge-3.sql sqlite3_purge.sql
	elif use mysql; then
		# Use existing configuration if possible
		if [[ -f ${ROOT}${CONFDIR}/mysql.data ]]; then
			DSPAM_DB_DATA=( $(sed "s:^[\t ]*$:###:gI" "${ROOT}${CONFDIR}/mysql.data") )
			for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
				[[ "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" = "###" ]] && DSPAM_DB_DATA[$DB_DATA_INDEX]=""
			done
		else
			DSPAM_DB_DATA[0]="/var/run/mysqld/mysqld.sock"
			DSPAM_DB_DATA[1]=""
			DSPAM_DB_DATA[2]="dspam"
			DSPAM_DB_DATA[3]="${PASSWORD}"
			DSPAM_DB_DATA[4]="dspam"
			DSPAM_DB_DATA[5]="true"
		fi

		# Modify configuration and create mysql.data file
		sed -e "s:^#*\(MySQLServer[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[0]}:gI" \
			-e "s:^#*\(MySQLPort[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[1]}:gI" \
			-e "s:^#*\(MySQLUser[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[2]}:gI" \
			-e "s:^#*\(MySQLPass[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[3]}:gI" \
			-e "s:^#*\(MySQLDb[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[4]}:gI" \
			-e "s:^#*\(MySQLCompress[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[5]}:gI" \
			-i ${T}/dspam.conf
		for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
			echo "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" >> ${T}/mysql.data
		done
		insinto ${CONFDIR}
		insopts -m644 -o dspam -g dspam
		doins ${T}/mysql.data
		newins src/tools.mysql_drv/mysql_objects-space.sql mysql_objects-space.sql
		newins src/tools.mysql_drv/mysql_objects-speed.sql mysql_objects-speed.sql
		newins src/tools.mysql_drv/mysql_objects-4.1.sql mysql_objects-4.1.sql
		newins src/tools.mysql_drv/virtual_users.sql mysql_virtual_users.sql
		newins src/tools.mysql_drv/purge.sql mysql_purge.sql
		newins src/tools.mysql_drv/purge-4.1.sql mysql_purge-4.1.sql

	elif use postgres ; then
		# Use existing configuration if possible
		if [ -f ${ROOT}${CONFDIR}/pgsql.data ]; then
			DSPAM_DB_DATA=( $(cat "${ROOT}${CONFDIR}/pgsql.data") )
			for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
				[[ "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" = "###" ]] && DSPAM_DB_DATA[$DB_DATA_INDEX]=""
			done
		else
			DSPAM_DB_DATA[0]="127.0.0.1"
			DSPAM_DB_DATA[1]="5432"
			DSPAM_DB_DATA[2]="dspam"
			DSPAM_DB_DATA[3]="${PASSWORD}"
			DSPAM_DB_DATA[4]="dspam"
		fi

		# Modify configuration and create pgsql.data file
		sed -e "s:^#*\(PgSQLServer[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[0]}:gI" \
			-e "s:^#*\(PgSQLPort[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[1]}:gI" \
			-e "s:^#*\(PgSQLUser[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[2]}:gI" \
			-e "s:^#*\(PgSQLPass[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[3]}:gI" \
			-e "s:^#*\(PgSQLDb[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[4]}:gI" \
			-e "s:^#*\(PgSQLConnectionCache[\t ]*.\):\1:gI" \
			-i ${T}/dspam.conf
		for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
			echo "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" >> ${T}/pgsql.data
		done

		insinto ${CONFDIR}
		insopts -m644 -o dspam -g dspam
		doins ${T}/pgsql.data
		newins src/tools.pgsql_drv/pgsql_objects.sql pgsql_objects.sql
		newins src/tools.pgsql_drv/virtual_users.sql pgsql_virtual_users.sql
		newins src/tools.pgsql_drv/purge.sql pgsql_purge.sql

	elif use oci8 ; then
		# Use existing configuration if possible
		if [ -f ${ROOT}${CONFDIR}/oracle.data ]; then
			DSPAM_DB_DATA=( $(cat "${ROOT}${CONFDIR}/oracle.data") )
			for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
				[[ "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" = "###" ]] && DSPAM_DB_DATA[$DB_DATA_INDEX]=""
			done
		else
			DSPAM_DB_DATA[0]="(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SID=PROD)))"
			DSPAM_DB_DATA[1]="dspam"
			DSPAM_DB_DATA[2]="${PASSWORD}"
			DSPAM_DB_DATA[3]="dspam"
		fi

		# Modify configuration and create oracle.data file
		sed -e "s:^#*\(OraServer[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[0]}:gI" \
			-e "s:^\(OraUser[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[1]}:gI" \
			-e "s:^\(OraPass[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[2]}:gI" \
			-e "s:^\(OraSchema[\t ]\{1,\}\).*:\1${DSPAM_DB_DATA[3]}:gI"\
		   	-i ${T}/dspam.conf
		for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
			echo "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" >> ${T}/oracle.data
		done

		insinto ${CONFDIR}
		insopts -m644 -o dspam -g dspam
		doins ${T}/oracle.data
		newins src/tools.ora_drv/oral_objects.sql ora_objects.sql
		newins src/tools.ora_drv/virtual_users.sql ora_virtual_users.sql
		newins src/tools.ora_drv/purge.sql ora_purge.sql
	fi

	sed -e "s:^\(Purge.*\):###\1:g" \
		-e "s:^#\(Purge.*\):\1:g" \
		-e "s:^###\(Purge.*\):#\1:g" \
		-i ${T}/dspam.conf
	insinto ${CONFDIR}
	insopts -m644 -o dspam -g dspam
	doins ${T}/dspam.conf

	# installs the notification messages
	# -> The documentation is wrong! The files need to be in ./txt
	diropts -m0775 -o dspam -g dspam
	dodir ${HOMEDIR}/txt
	keepdir ${HOMEDIR}/txt
	insinto ${HOMEDIR}/txt
	insopts -m644 -o dspam -g dspam
	doins ${S}/txt/*.txt

	# Create the opt-in / opt-out directories
	diropts -m0775 -o dspam -g dspam
	dodir ${HOMEDIR}/opt-in
	keepdir ${HOMEDIR}/opt-in
	dodir ${HOMEDIR}/opt-out
	keepdir ${HOMEDIR}/opt-out

	# logrotation scripts
	diropts -m0755 -o dspam -g dspam
	dodir /etc/logrotate.d
	keepdir /etc/logrotate.d
	insinto /etc/logrotate.d
	insopts -m0644 -o dspam -g dspam
	newins ${FILESDIR}/logrotate.dspam dspam

	# dspam cron job
	diropts -m0755 -o dspam -g dspam
	dodir /etc/cron.daily
	keepdir /etc/cron.daily
	exeinto /etc/cron.daily
	exeopts -m0755 -o dspam -g dspam
	doexe ${FILESDIR}/dspam.cron

	# dspam enviroment
	echo -ne "CONFIG_PROTECT=\"${CONFDIR} /var/run/dspam\"\n\n" > ${T}/40dspam
	doenvd ${T}/40dspam || die
}

pkg_postinst() {
	# need enewgroup/enewuser in this function for binary install.
	enewgroup dspam 26
	enewuser dspam 26 /bin/bash ${HOMEDIR} dspam

	env-update
	if use mysql || use postgres || use oci8; then
		echo
		einfo "To setup DSPAM to run out-of-the-box on your system with a MySQL,"
		einfo "PostgreSQL or Oracle database, run:"
		einfo "emerge --config =${PF}"
	fi

	if has_version ">dev-db/postgresql-8.0"; then
		echo
		einfo "Before executing the configuration command mentioned above you have"
		einfo "to execute the following command:"
		einfo "createlang plpgsql -U postgres dspam"
	fi

	if use daemon; then
		if has_version ">sys-kernel/linux-headers-2.6"; then
			einfo "If you want to run DSPAM in the new daemon mode remember"
			einfo "to make the DSPAM daemon start during boot:"
			einfo "  rc-update add dspam default"
		fi
	fi
	if use exim ; then
		echo
		einfo "To use dspam in conjunction with your exim system, you should read the README"
	fi
}

pkg_config () {
	if use sqlite ; then
		einfo "sqlite_drv will automatically create the necessary database"
	elif use mysql ; then
		DSPAM_DB_DATA=( $(sed "s:^[\t ]*$:###:gI" "${ROOT}${CONFDIR}/mysql.data") )
		for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
			[[ "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" = "###" ]] && DSPAM_DB_DATA[$DB_DATA_INDEX]=""
		done
		DSPAM_MySQL_USER="${DSPAM_DB_DATA[2]}"
		DSPAM_MySQL_PWD="${DSPAM_DB_DATA[3]}"
		DSPAM_MySQL_DB="${DSPAM_DB_DATA[4]}"

		ewarn "When prompted for a password, please enter your MySQL root password"
		ewarn

		einfo "Creating DSPAM MySQL database \"${DSPAM_MySQL_DB}\""
		/usr/bin/mysqladmin -u root -p create ${DSPAM_MySQL_DB}

		einfo "Creating DSPAM MySQL tables for data objects"
		einfo "  Please select what kind of object database you like to use."
		einfo "    [1] Space optimized database"
		einfo "    [2] Speed optimized database"
		einfo
		while true
		do
			read -n 1 -s -p "  Press 1 or 2 on the keyboard to select database" DSPAM_MySQL_DB_Type
			[[ "${DSPAM_MySQL_DB_Type}" == "1" || "${DSPAM_MySQL_DB_Type}" == "2" ]] && echo && break
		done

		if [ "${DSPAM_MySQL_DB_Type}" == "1" ]
		then
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${CONFDIR}/mysql_objects-space.sql
		else
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${CONFDIR}/mysql_objects-speed.sql
		fi

		if use virtual-users ; then
			einfo "Creating DSPAM MySQL database for virtual-users users"
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${CONFDIR}/mysql_virtual_users.sql
		fi

		einfo "Creating DSPAM MySQL user \"${DSPAM_MySQL_USER}\""
		/usr/bin/mysql -u root -p -e "GRANT SELECT,INSERT,UPDATE,DELETE ON ${DSPAM_MySQL_DB}.* TO ${DSPAM_MySQL_USER}@localhost IDENTIFIED BY '${DSPAM_MySQL_PWD}';FLUSH PRIVILEGES;" -D mysql
	elif use postgres ; then
		DSPAM_DB_DATA=( $(sed "s:^[\t ]*$:###:gI" "${ROOT}${CONFDIR}/pgsql.data") )
		for DB_DATA_INDEX in $(seq 0 $((${#DSPAM_DB_DATA[@]} - 1))); do
			[[ "${DSPAM_DB_DATA[$DB_DATA_INDEX]}" = "###" ]] && DSPAM_DB_DATA[$DB_DATA_INDEX]=""
		done
		DSPAM_PgSQL_USER="${DSPAM_DB_DATA[2]}"
		DSPAM_PgSQL_PWD="${DSPAM_DB_DATA[3]}"
		DSPAM_PgSQL_DB="${DSPAM_DB_DATA[4]}"

		ewarn "When prompted for a password, please enter your PgSQL postgres password"
		ewarn

		einfo "Creating DSPAM PostgreSQL database \"${DSPAM_PgSQL_DB}\" and user \"${DSPAM_PgSQL_USER}\""
		/usr/bin/psql -h localhost -d template1 -U postgres -c "CREATE USER ${DSPAM_PgSQL_USER} WITH PASSWORD '${DSPAM_PgSQL_PWD}' NOCREATEDB NOCREATEUSER; CREATE DATABASE ${DSPAM_PgSQL_DB}; GRANT ALL PRIVILEGES ON DATABASE ${DSPAM_PgSQL_DB} TO ${DSPAM_PgSQL_USER}; GRANT ALL PRIVILEGES ON SCHEMA public TO ${DSPAM_PgSQL_USER}; UPDATE pg_database SET datdba=(SELECT usesysid FROM pg_shadow WHERE usename='${DSPAM_PgSQL_USER}') WHERE datname='${DSPAM_PgSQL_DB}';"

		einfo "Creating DSPAM PostgreSQL tables"
		PGUSER=${DSPAM_PgSQL_USER} PGPASSWORD=${DSPAM_PgSQL_PWD} /usr/bin/psql -d ${DSPAM_PgSQL_DB} -U ${DSPAM_PgSQL_USER} -f ${CONFDIR}/pgsql_objects.sql 1>/dev/null 2>&1

		if use virtual-users ; then
			einfo "Creating DSPAM PostgreSQL database for virtual-users users"
			PGUSER=${DSPAM_PgSQL_USER} PGPASSWORD=${DSPAM_PgSQL_PWD} /usr/bin/psql -d ${DSPAM_PgSQL_DB} -U ${DSPAM_PgSQL_USER} -f ${CONFDIR}/pgsql_virtual_users.sql 1>/dev/null 2>&1
		fi
	elif use oci8 ; then
		einfo "We have not enought Oracle knowledge to configure Oracle"
		einfo "automatically. If you know how, please post a message in"
		einfo "Gentoo Bugzilla."
		einfo
		einfo "You need manually to create the Oracle user for DSPAM and"
		einfo "the necessary database."
		einfo "But the DSPAM configuration file dspam.conf and oracle.data"
		einfo "was already configured with the necessary information to"
		einfo "access the database."
		einfo "Please read your dspam.conf, oracle.data and the README for"
		einfo "more info on how to setup DSPAM with Oracle."
		einfo "objects for each user upon first use of DSPAM by that user."
	fi
}
