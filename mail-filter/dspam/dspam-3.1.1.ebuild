# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dspam/dspam-3.1.1.ebuild,v 1.9 2004/10/28 14:40:36 st_lim Exp $

inherit eutils

MY_PV=${PV/_beta20/.beta.2}
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="A statistical-algorithmic hybrid anti-spam filter"
SRC_URI="http://www.nuclearelephant.com/projects/dspam/sources/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.nuclearelephant.com/projects/dspam/index.html"
LICENSE="GPL-2"

IUSE="cyrus debug exim mysql maildrop neural oci8 postgres procmail"
DEPEND="exim? ( >=mail-mta/exim-4.34 )
		mysql? ( >=dev-db/mysql-3.23 ) || ( >=sys-libs/db-4.0 )
		maildrop? ( >=mail-filter/maildrop-1.5.3 )
		postgres? ( >=dev-db/postgresql-7.4.3 )
		procmail? ( >=mail-filter/procmail-3.22 )
		x86? ( cyrus? ( >=net-mail/cyrus-imapd-2.1.15 ) )
		"
RDEPEND="virtual/cron
		app-admin/logrotate"
KEYWORDS="~x86 ~ppc"
SLOT="0"

# some FHS-like structure
HOMEDIR="/etc/mail/dspam"
DATADIR="/var/spool/dspam"
LOGDIR="/var/log/dspam"
CONFIGDIR="${HOMEDIR}/config"

pkg_setup() {
	if (use mysql && use postgres) || \
		(use mysql && use oci8) || \
		(use postgres && use oci8); then
		echo
		ewarn "You have two of either \"mysql\", \"postgres\" or \"oci\" in your USE flags."
		ewarn "Will default to MySQL as your dspam database backend."
		ewarn "If you want to build with Postgres support; hit Control-C now."
		ewarn "Change your USE flag -mysql and emerge again."
		echo
		has_version ">=sys-apps/portage-2.0.50" && (
		einfo "It would be best practice to add the set of USE flags that you use for this"
		einfo "package to the file: /etc/portage/package.use. Example:"
		einfo "\`echo \"net-mail/dspam -mysql postgres\" >> /etc/portage/package.use\`"
		einfo "to build dspam with Postgres database as your dspam backend."
		)
		echo
		ewarn "Waiting 30 seconds before starting..."
		ewarn "(Control-C to abort)..."
		epause 30
	fi
	id dspam 2>/dev/null || enewgroup dspam 65532
	id dspam 2>/dev/null || enewuser dspam 65532 /bin/bash ${HOMEDIR} dspam
}

src_compile() {
	local myconf
	local agent

	# these are the default settings
	myconf="${myconf} --with-signature-life=14"
	if use cyrus; then
		agent="/usr/lib/cyrus/deliver %u"
	elif use exim; then
		agent="/usr/sbin/exim -oMr spam-scanned %u"
	elif use maildrop; then
		agent="/usr/bin/maildrop -d %u"
	elif use procmail; then
		agent="/usr/bin/procmail"
	else
		agent="/usr/sbin/sendmail"
	fi
	myconf="${myconf} --enable-source-address-tracking"
	myconf="${myconf} --enable-large-scale"
	myconf="${myconf} --enable-long-username"
	myconf="${myconf} --enable-spam-subject"
	myconf="${myconf} --enable-signature-headers"
	myconf="${myconf} --enable-whitelist"
	#myconf="${myconf} --enable-chi-square"
	#myconf="${myconf} --enable-robinson"
	#myconf="${myconf} --enable-robinson-pvalues"

	# ${HOMEDIR}/data is a symlink to ${DATADIR}
	myconf="${myconf} --with-dspam-home=${HOMEDIR}"
	myconf="${myconf} --with-dspam-mode=4755"
	myconf="${myconf} --with-dspam-owner=dspam"
	myconf="${myconf} --with-dspam-group=dspam"
	myconf="${myconf} --with-dspam-home-owner=dspam"
	myconf="${myconf} --with-dspam-home-group=dspam"
	myconf="${myconf} --with-dspam-home-mode=4755"

	# enables support for debugging (touch /etc/dspam/.debug to turn on)
	# optional: even MORE debugging output, use with extreme caution!
	use debug && myconf="${myconf} --enable-debug --enable-verbose-debug"

	# select storage driver
	if use mysql ; then
		myconf="${myconf} --with-storage-driver=mysql_drv"
		myconf="${myconf} --with-mysql-includes=/usr/include/mysql"
		myconf="${myconf} --with-mysql-libraries=/usr/lib/mysql"
		myconf="${myconf} --with-client-compression"
		myconf="${myconf} --enable-virtual-users"

		# an experimental feature available with MySQL and PgSQL backend
		if use neural ; then
			myconf="${myconf} --enable-neural-networking"
		fi
	elif use postgres ; then
		myconf="${myconf} --with-storage-driver=pgsql_drv"
		myconf="${myconf} --with-pgsql-includes=/usr/include/postgresql"
		myconf="${myconf} --with-pgsql-libraries=/usr/lib/postgresql"
		myconf="${myconf} --enable-virtual-users"

		# an experimental feature available with MySQL and PgSQL backend
		if use neural ; then
			myconf="${myconf} --enable-neural-networking"
		fi
	elif use oci8 ; then
		myconf="${myconf} --with-storage-driver=ora_drv"
		myconf="${myconf} --with-oracle-home=${ORACLE_HOME}"
		myconf="${myconf} --enable-virtual-users"

		# I am in no way a Oracle specialist. If someone knows
		# how to query the version of Oracle, then let me know.
		if (expr ${ORACLE_HOME/*\/} : 10 1>/dev/null 2>&1)
		then
			--with-oracle-version=MAJOR
			myconf="${myconf} --with-oracle-version=10"
		fi
	else
		myconf="${myconf} --with-storage-driver=libdb4_drv"
		myconf="${myconf} --with-db4-includes=/usr/include"
		myconf="${myconf} --with-db4-libraries=/usr/lib"
	fi

	econf ${myconf} \
		--with-delivery-agent="${agent}" || die
	emake || die

}

src_install () {
	# open up perms on /etc/mail/dspam
	diropts -m0775 -o dspam -g dspam
	dodir ${HOMEDIR}
	keepdir ${HOMEDIR}

	# keeps dspam data in /var
	diropts -m0775 -o dspam -g dspam
	dodir ${DATADIR}
	keepdir ${DATADIR}

	# keeps dspam log in /var/log
	diropts -m0775 -o dspam -g dspam
	dodir ${LOGDIR}
	keepdir ${LOGDIR}

	# make install
	make DESTDIR=${D} install || die
	chmod 4755 ${D}/usr/bin/dspam

	# documentation
	dodoc CHANGELOG LICENSE README RELEASE.NOTES
	dodoc ${FILESDIR}/README.postfix ${FILESDIR}/README.qmail
	if use mysql ; then
		newdoc tools.mysql_drv/README README.MYSQL
	elif use postgres ; then
		newdoc tools.pgsql_drv/README README.PGSQL
	elif use oci8 ; then
		newdoc tools.ora_drv/README README.ORACLE
	fi

	# build some initial configuration data
	(echo "trainingMode=TEFT"
	echo "spamAction=deliver"
	echo "spamSubject=[SPAM]"
	echo "statisticalSedation=5"
	echo "enableBNR=on"
	echo "enableWhitelist=on") >${T}/default.prefs
	echo "groupname:classification:*globaluser" >${T}/group
	if use cyrus; then
		echo "/usr/lib/cyrus/deliver %u" > ${T}/untrusted.mailer_args
	elif use exim; then
		echo "/usr/sbin/exim -oMr spam-scanned" > ${T}/untrusted.mailer_args
	elif use maildrop; then
		echo "/usr/bin/maildrop -d %u" > ${T}/untrusted.mailer_args
	elif use procmail; then
		echo "/usr/bin/procmail -d %u" > ${T}/untrusted.mailer_args
	else
		echo "/usr/sbin/sendmail" >  ${T}/untrusted.mailer_args
	fi

	# install some initial configuration
	insinto ${HOMEDIR}
	insopts -m0664 -o dspam -g dspam
	[ ! -f ${HOMEDIR}/trusted.users ] && doins ${FILESDIR}/trusted.users
	doins ${T}/untrusted.mailer_args
	doins ${T}/default.prefs
	doins ${T}/group

	local PASSWORD="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"

	# database related configuration and scripts
	if use mysql ; then
		insinto ${CONFIGDIR}
		insopts -m644 -o dspam -g dspam

		if [ -f ${HOMEDIR}/mysql.data ]; then
			# Use an existing password
			PASSWORD="$(tail -n 2 ${HOMEDIR}/mysql.data | head -n 1 )"
		else
			# Create the mysql.data file
			echo "127.0.0.1" >${T}/mysql.data
			echo "3306" >>${T}/mysql.data
			echo "dspam" >>${T}/mysql.data
			echo "${PASSWORD}" >>${T}/mysql.data
			echo "dspam" >>${T}/mysql.data
			doins ${T}/mysql.data
		fi

		newins tools.mysql_drv/mysql_objects.sql.speed.optimized mysql_objects.sql.speed.optimized
		newins tools.mysql_drv/mysql_objects.sql.space.optimized mysql_objects.sql.space.optimized
		newins tools.mysql_drv/virtual_users.sql mysql_virtual_users.sql
		newins tools.mysql_drv/purge.sql mysql_purge.sql
		newins ${FILESDIR}/upgrade.sql mysql_upgrade.sql
	elif use postgres ; then
		insinto ${CONFIGDIR}
		insopts -m644 -o dspam -g dspam

		if [ -f ${HOMEDIR}/mysql.data ]; then
			# Use an existing password
			PASSWORD="$(tail -n 2 ${HOMEDIR}/pgsql.data | head -n 1 )"
		else
			# Create the pgsql.data file
			echo "127.0.0.1" >${T}/pgsql.data
			echo "5432" >>${T}/pgsql.data
			echo "dspam" >>${T}/pgsql.data
			echo "${PASSWORD}" >>${T}/pgsql.data
			echo "dspam" >>${T}/pgsql.data
			doins ${T}/pgsql.data
		fi

		newins tools.pgsql_drv/pgsql_objects.sql pgsql_objects.sql
		newins tools.pgsql_drv/virtual_users.sql pgsql_virtual_users.sql
		newins tools.pgsql_drv/purge.sql pgsql_purge.sql

	elif use oci8 ; then
		insinto ${CONFIGDIR}
		insopts -m644 -o dspam -g dspam

		if [ -f ${HOMEDIR}/oracle.data ]; then
			# Use an existing password
			PASSWORD="$(tail -n 2 ${HOMEDIR}/oracle.data | head -n 1 )"
		else
			# Create the pgsql.data file
			echo "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SID=PROD)))" >${T}/oracle.data
			echo "dspam" >>${T}/oracle.data
			echo "${PASSWORD}" >>${T}/oracle.data
			echo "dspam" >>${T}/oracle.data
			doins ${T}/oracle.data
		fi

		newins tools.ora_drv/oral_objects.sql ora_objects.sql
		newins tools.ora_drv/virtual_users.sql ora_virtual_users.sql
		newins tools.ora_drv/purge.sql ora_purge.sql
	fi

	# installs the cron job to the cron directory
	diropts -m0755 -o dspam -g dspam
	dodir /etc/cron.daily
	keepdir /etc/cron.daily
	exeinto /etc/cron.daily
	exeopts -m0755 -o dspam -g dspam
	doexe ${FILESDIR}/dspam.cron

	# installs the logrotation scripts to the logrotate.d directory
	diropts -m0755 -o dspam -g dspam
	dodir /etc/logrotate.d
	keepdir /etc/logrotate.d
	insinto /etc/logrotate.d
	insopts -m0755 -o dspam -g dspam
	newins ${FILESDIR}/logrotate.dspam dspam

	# Symlinks data to HOMEDIR
	dosym ${DATADIR} ${HOMEDIR}/data

	# Log files for symlinks
	diropts -m0755 -o dspam -g dspam
	dodir ${LOGDIR}
	keepdir ${LOGDIR}
	touch ${T}/empty.file
	newins ${T}/empty.file sql.errors
	newins ${T}/empty.file system.log
	newins ${T}/empty.file dspam.debug
	newins ${T}/empty.file dspam.messages

	# dspam still wants to write to a few files in it's home dir
	dosym ${LOGDIR}/sql.errors ${HOMEDIR}/sql.errors
	dosym ${LOGDIR}/system.log ${HOMEDIR}/system.log
	dosym ${LOGDIR}/dspam.debug ${HOMEDIR}/dspam.debug
	dosym ${LOGDIR}/dspam.messages ${HOMEDIR}/dspam.messages

	# dspam enviroment
	echo -ne "CONFIG_PROTECT_MASK=\"${HOMEDIR} ${CONFIGDIR}\"\n\n" > ${T}/40dspam
	doenvd ${T}/40dspam || die
}

pkg_postinst() {
	if use mysql || use postgres; then
		einfo "To setup dspam to run out-of-the-box on your system with a mysql or pgsql database, run:"
		einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	fi
	if use exim ; then
		echo
		einfo "To use dspam in conjunction with your exim system, you should read the README"
	fi
}

pkg_config () {
	if use mysql ; then
		[[ -f ${CONFIGDIR}/mysql.data ]] && mv -f ${CONFIGDIR}/mysql.data ${HOMEDIR}
		DSPAM_MySQL_USER="$(cat ${HOMEDIR}/mysql.data|head -n 3|tail -n 1)"
		DSPAM_MySQL_PWD="$(cat ${HOMEDIR}/mysql.data|head -n 4|tail -n 1)"
		DSPAM_MySQL_DB="$(cat ${HOMEDIR}/mysql.data|head -n 5|tail -n 1)"

		ewarn "When prompted for a password, please enter your MySQL root password"
		ewarn ""

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
			[[ "${DSPAM_MySQL_DB_Type}" == "1" || "${DSPAM_MySQL_DB_Type}" == "2" ]] && break
		done

		if [ "${DSPAM_MySQL_DB_Type}" == "1" ]
		then
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${CONFIGDIR}/mysql_objects.sql.space.optimized
		else
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${CONFIGDIR}/mysql_objects.sql.speed.optimized
		fi

		einfo "Creating DSPAM MySQL database for virtual users"
		/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${CONFIGDIR}/mysql_virtual_users.sql

		einfo "Creating DSPAM MySQL user \"${DSPAM_MySQL_USER}\""
		/usr/bin/mysql -u root -p -e "GRANT SELECT,INSERT,UPDATE,DELETE ON ${DSPAM_MySQL_DB}.* TO ${DSPAM_MySQL_USER}@localhost IDENTIFIED BY '${DSPAM_MySQL_PWD}';FLUSH PRIVILEGES;" -D mysql
	elif use postgres ; then
		[[ -f ${CONFIGDIR}/pgsql.data ]] && mv -f ${CONFIGDIR}/pgsql.data ${HOMEDIR}
		DSPAM_PgSQL_USER="$(cat ${HOMEDIR}/pgsql.data|head -n 3|tail -n 1)"
		DSPAM_PgSQL_PWD="$(cat ${HOMEDIR}/pgsql.data|head -n 4|tail -n 1)"
		DSPAM_PgSQL_DB="$(cat ${HOMEDIR}/pgsql.data|head -n 5|tail -n 1)"

		ewarn "When prompted for a password, please enter your PgSQL postgres password"
		ewarn ""

		einfo "Creating DSPAM PostgreSQL user \"${DSPAM_PgSQL_USER}\""
		/usr/bin/psql -d template1 -U postgres -c "CREATE USER ${DSPAM_PgSQL_USER} WITH PASSWORD '${DSPAM_PgSQL_PWD}' NOCREATEDB NOCREATEUSER;" 1>/dev/null 2>&1

		einfo "Creating DSPAM PostgreSQL database \"${DSPAM_PgSQL_DB}\""
		/usr/bin/psql -d template1 -U postgres -c "CREATE DATABASE ${DSPAM_PgSQL_DB};" 1>/dev/null 2>&1

		einfo "Getting DSPAM PostgreSQL userid for \"${DSPAM_PgSQL_USER}\""
		DSPAM_PgSQL_USERID=$(/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -t -c "SELECT usesysid FROM pg_user WHERE usename='${DSPAM_PgSQL_USER}';" | head -n1 | sed "s/^[ ]*\([^ ]*\).*/\1/g")
		einfo "  UserID: ${DSPAM_PgSQL_USERID}"

		einfo "Getting DSPAM PostgreSQL databaseid for \"${DSPAM_PgSQL_DB}\""
		DSPAM_PgSQL_DBID=$(/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -t -c "SELECT datdba FROM pg_database WHERE datname='${DSPAM_PgSQL_DB}';" | head -n1 | sed "s/^[ ]*\([^ ]*\).*/\1/g")
		einfo "  DBID: ${DSPAM_PgSQL_DBID}"

		einfo "Changing owner of DSPAM PostgreSQL database \"${DSPAM_PgSQL_DB}\" to \"${DSPAM_PgSQL_USER}\""
		/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "UPDATE pg_database SET datdba=${DSPAM_PgSQL_USERID} WHERE datname='${DSPAM_PgSQL_DB}';" 1>/dev/null 2>&1

		einfo "Creating DSPAM PostgreSQL tables"
		PGUSER=${DSPAM_PgSQL_USER} PGPASSWORD=${DSPAM_PgSQL_PWD} /usr/bin/psql -d ${DSPAM_PgSQL_DB} -U ${DSPAM_PgSQL_USER} -f ${CONFIGDIR}/pgsql_objects.sql 1>/dev/null 2>&1
		PGUSER=${DSPAM_PgSQL_USER} PGPASSWORD=${DSPAM_PgSQL_PWD} /usr/bin/psql -d ${DSPAM_PgSQL_DB} -U ${DSPAM_PgSQL_USER} -f ${CONFIGDIR}/pgsql_virtual_users.sql 1>/dev/null 2>&1

		einfo "Grant privileges to DSPAM PostgreSQL objects to \"${DSPAM_PgSQL_USER}\""
		for foo in $(/usr/bin/psql -t -d ${DSPAM_PgSQL_DB} -U postgres -c "SELECT tablename FROM pg_tables WHERE tablename LIKE 'dspam\%';")
		do
			/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "GRANT ALL PRIVILEGES ON TABLE ${foo} TO ${DSPAM_PgSQL_USER};" 1>/dev/null 2>&1
		done
		/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE ${DSPAM_PgSQL_DB} TO ${DSPAM_PgSQL_USER};" 1>/dev/null 2>&1
		/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "GRANT ALL PRIVILEGES ON SCHEMA public TO ${DSPAM_PgSQL_USER};" 1>/dev/null 2>&1
	elif use oci8 ; then
		[[ -f ${CONFIGDIR}/oracle.data ]] && mv -f ${CONFIGDIR}/oracle.data ${HOMEDIR}
	fi

}
