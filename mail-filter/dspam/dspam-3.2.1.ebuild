# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dspam/dspam-3.2.1.ebuild,v 1.1 2004/11/04 16:33:44 st_lim Exp $

inherit eutils

S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="A statistical-algorithmic hybrid anti-spam filter"
SRC_URI="http://www.nuclearelephant.com/projects/dspam/sources/${PN}-${PV}.tar.gz"
HOMEPAGE="http://www.nuclearelephant.com/projects/dspam/index.html"
LICENSE="GPL-2"

IUSE="cyrus debug exim mysql mysql41 maildrop neural oci8 postgres procmail sqlite"
DEPEND="exim? ( >=mail-mta/exim-4.34 )
		mysql? ( >=dev-db/mysql-3.23 ) || ( >=sys-libs/db-4.0 )
		sqlite? ( >=dev-db/sqlite-3.0.6 )
		maildrop? ( >=mail-filter/maildrop-1.5.3 )
		postgres? ( >=dev-db/postgresql-7.4.3 )
		procmail? ( >=mail-filter/procmail-3.22 )
		x86? ( cyrus? ( >=net-mail/cyrus-imapd-2.1.15 ) )
		"
		#mysql41? ( >=dev-db/mysql-4.1 ) # There is no mysql-4.1 in gentoo!!!  Ouch
RDEPEND="virtual/cron
		app-admin/logrotate"
KEYWORDS="~x86 ~ppc"
SLOT="0"

# some FHS-like structure
HOMEDIR="/etc/mail/dspam"
DATADIR="/var/spool/dspam"
LOGDIR="/var/log/dspam"

pkg_setup() {
	if (use mysql && use postgres) || \
		(use mysql && use oci8) || \
		(use mysql && use sqlite) || \
		(use postgres && use oci8) || \
		(use postgres && use sqlite) || \
		(use sqlite && use oci8); then
		echo
		ewarn "You have two of either \"mysql\", \"postgres\", \"oci8\" or \"sqlite\" in your USE flags."
		ewarn "Will default to MySQL as your dspam database backend."
		ewarn "If you want to build with Postgres/Oracle/SQLite support; hit Control-C now."
		ewarn "Change your USE flag -mysql and emerge again."
		echo
		has_version ">=sys-apps/portage-2.0.50" && (
		einfo "It would be best practice to add the set of USE flags that you use for this"
		einfo "package to the file: /etc/portage/package.use. Example:"
		einfo "\`echo \"net-mail/dspam -mysql postgres -oci8 -sqlite\" >> /etc/portage/package.use\`"
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

	# these are the default settings
	myconf="${myconf} --with-signature-life=14"
	myconf="${myconf} --enable-broken-return-codes"
	myconf="${myconf} --enable-experimental"
	myconf="${myconf} --enable-long-username"
	myconf="${myconf} --enable-robinson"
	#myconf="${myconf} --enable-chi-square"
	myconf="${myconf} --enable-robinson-pvalues"
	#myconf="${myconf} --enable-broken-mta"
	myconf="${myconf} --enable-large-scale"
	#myconf="${myconf} --enable-domain-scale"

	# ${HOMEDIR}/data is a symlink to ${DATADIR}
	myconf="${myconf} --with-dspam-mode=4755"
	myconf="${myconf} --with-dspam-owner=dspam"
	myconf="${myconf} --with-dspam-group=dspam"
	myconf="${myconf} --enable-homedir --with-dspam-home=${HOMEDIR} --sysconfdir=${HOMEDIR}"
	myconf="${myconf} --with-logdir=/var/log/dspam"

	# enables support for debugging (touch /etc/dspam/.debug to turn on)
	# optional: even MORE debugging output, use with extreme caution!
	use debug && myconf="${myconf} --enable-debug --enable-verbose-debug"

	# select storage driver
	if use mysql || use mysql41; then
		myconf="${myconf} --with-storage-driver=mysql_drv"
		myconf="${myconf} --with-mysql-includes=/usr/include/mysql"
		myconf="${myconf} --with-mysql-libraries=/usr/lib/mysql"
		myconf="${myconf} --with-client-compression"
		myconf="${myconf} --enable-virtual-users"
		myconf="${myconf} --enable-preferences-extension"

		# an experimental feature available with MySQL and PgSQL backend
		if use neural ; then
			myconf="${myconf} --enable-neural-networking"
		fi
	elif use postgres ; then
		myconf="${myconf} --with-storage-driver=pgsql_drv"
		myconf="${myconf} --with-pgsql-includes=/usr/include/postgresql"
		myconf="${myconf} --with-pgsql-libraries=/usr/lib/postgresql"
		myconf="${myconf} --enable-virtual-users"
		myconf="${myconf} --enable-preferences-extension"

		# an experimental feature available with MySQL and PgSQL backend
		if use neural ; then
			myconf="${myconf} --enable-neural-networking"
		fi
	elif use oci8 ; then
		myconf="${myconf} --with-storage-driver=ora_drv"
		myconf="${myconf} --with-oracle-home=${ORACLE_HOME}"
		myconf="${myconf} --enable-virtual-users"
		myconf="${myconf} --enable-preferences-extension"

		# I am in no way a Oracle specialist. If someone knows
		# how to query the version of Oracle, then let me know.
		if (expr ${ORACLE_HOME/*\/} : 10 1>/dev/null 2>&1)
		then
			--with-oracle-version=MAJOR
			myconf="${myconf} --with-oracle-version=10"
		fi
	elif use sqlite ; then
		myconf="${myconf} --with-storage-driver=sqlite_drv"
		myconf="${myconf} --enable-virtual-users"
		myconf="${myconf} --enable-preferences-extension"

	else
		myconf="${myconf} --with-storage-driver=libdb4_drv"
	fi

	econf ${myconf} || die
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
	sed -e 's/rm -f ..mandir.\(.*\)/rm -f ${D}${mandir}\1/g' \
		-e 's/ln -s ..mandir.\(.*\) ..mandir.\(.*3\)/ln -s ${mandir}\1.gz ${D}${mandir}\2.gz/g' \
		-i Makefile
	make DESTDIR=${D} install || die
	chmod 4755 ${D}/usr/bin/dspam

	# documentation
	dodoc CHANGELOG LICENSE README RELEASE.NOTES
	dodoc ${FILESDIR}/README.postfix ${FILESDIR}/README.qmail
	if use mysql || mysql41; then
		newdoc tools.mysql_drv/README
	elif use postgres ; then
		newdoc tools.pgsql_drv/README
	elif use oci8 ; then
		newdoc tools.ora_drv/README
	elif use sqlite ; then
		newdoc tools.sqlite_drv/README
	fi

	# build some initial configuration data
	[ -f ${HOMEDIR}/dspam.conf ] && cp ${HOMEDIR}/dspam.conf ${D}${HOMEDIR}/dspam.conf
	if [ ! -f ${HOMEDIR}/dspam.conf ]; then
		if use cyrus; then
			echo "UntrustedDeliveryAgent /usr/lib/cyrus/deliver %u" >> ${D}${HOMEDIR}/dspam.conf
			sed -e 's:/usr/bin/procmail:/usr/lib/cyrus/deliver %u:g' \
				-i ${D}${HOMEDIR}/dspam.conf
		elif use exim; then
			echo "UntrustedDeliveryAgent /usr/sbin/exim -oMr spam-scanned %u" >> ${D}${HOMEDIR}/dspam.conf
			sed -e 's:/usr/bin/procmail:/usr/sbin/exim -oMr spam-scanned %u:g' \
				-i ${D}${HOMEDIR}/dspam.conf
		elif use maildrop; then
			echo "UntrustedDeliveryAgent /usr/bin/maildrop -d %u" >> ${D}${HOMEDIR}/dspam.conf
			sed -e 's:/usr/bin/procmail:/usr/bin/maildrop -d %u:g' \
				-i ${D}${HOMEDIR}/dspam.conf
		elif use procmail; then
			echo "UntrustedDeliveryAgent /usr/bin/procmail" >> ${D}${HOMEDIR}/dspam.conf
		else
			echo "UntrustedDeliveryAgent /usr/sbin/sendmail" >> ${D}${HOMEDIR}/dspam.conf
			sed -e 's:/usr/bin/procmail:/usr/sbin/sendmail:g' \
				-i ${D}${HOMEDIR}/dspam.conf
		fi
	fi

	local PASSWORD="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"

	# database related configuration and scripts
	if use mysql || use mysql41; then
		insinto ${HOMEDIR}
		insopts -m644 -o dspam -g dspam

		if [ -f ${HOMEDIR}/mysql.data ]; then
			# Use an existing password
			PASSWORD="$(tail -n 2 ${HOMEDIR}/mysql.data | head -n 1 )"
		else
			# Create the mysql.data file
			echo "MySQLServer    /var/run/mysqld/mysqld.sock" >> ${T}/mysql.data
			echo "MySQLPort"                                  >> ${T}/mysql.data
			echo "MySQLUser      dspam"                       >> ${T}/mysql.data
			echo "MySQLPass      ${PASSWORD}"                 >> ${T}/mysql.data
			echo "MySQLDb        dspam"                       >> ${T}/mysql.data
			echo "MySQLCompress  true"                        >> ${T}/mysql.data
			doins ${T}/mysql.data
			[ -z "`grep '^MySQL' ${D}/${HOMEDIR}/dspam.conf`" ] && cat ${T}/mysql.data >> ${D}/${HOMEDIR}/dspam.conf
		fi

		newins tools.mysql_drv/mysql_objects-space.sql mysql_objects-space.sql
		newins tools.mysql_drv/mysql_objects-speed.sql mysql_objects-speed.sql
		newins tools.mysql_drv/mysql_objects-4.1.sql mysql_objects-4.1.sql
		newins tools.mysql_drv/virtual_users.sql mysql_virtual_users.sql
		newins tools.mysql_drv/neural.sql mysql_neural.sql
		newins tools.mysql_drv/purge.sql mysql_purge.sql
		newins tools.mysql_drv/purge-4.1.sql mysql_purge-4.1.sql
		newins ${FILESDIR}/upgrade.sql mysql_upgrade.sql
	elif use postgres ; then
		insinto ${HOMEDIR}
		insopts -m644 -o dspam -g dspam

		if [ -f ${HOMEDIR}/mysql.data ]; then
			# Use an existing password
			PASSWORD="$(tail -n 2 ${HOMEDIR}/pgsql.data | head -n 1 )"
		else
			# Create the pgsql.data file
			echo "PgSQLServer    127.0.0.1"    >> ${T}/mysql.data
			echo "PgSQLPort      5432"         >> ${T}/mysql.data
			echo "PgSQLUser      dspam"        >> ${T}/mysql.data
			echo "PgSQLPass      ${PASSWORD}"  >> ${T}/mysql.data
			echo "PgSQLDb        dspam"        >> ${T}/mysql.data
			doins ${T}/pgsql.data
			[ -z "`grep '^PgSQL' ${D}/${HOMEDIR}/dspam.conf`" ] && cat ${T}/pgsql.data >> ${D}/${HOMEDIR}/dspam.conf
		fi

		newins tools.pgsql_drv/pgsql_objects.sql pgsql_objects.sql
		newins tools.pgsql_drv/virtual_users.sql pgsql_virtual_users.sql
		newins tools.pgsql_drv/purge.sql pgsql_purge.sql

	elif use oci8 ; then
		insinto ${HOMEDIR}
		insopts -m644 -o dspam -g dspam

		if [ -f ${HOMEDIR}/oracle.data ]; then
			# Use an existing password
			PASSWORD="$(tail -n 2 ${HOMEDIR}/oracle.data | head -n 1 )"
		else
			# Create the pgsql.data file
			echo "OraServer      (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SID=PROD)))" >>${T}/oracle.data
			echo "OraUser        dspam" >>${T}/oracle.data
			echo "OraPass        ${PASSWORD}" >>${T}/oracle.data
			echo "OraSchema      dspam" >>${T}/oracle.data
			doins ${T}/oracle.data
			[ -z "`grep '^Ora' ${D}/${HOMEDIR}/dspam.conf`" ] && cat ${T}/oracle.data >> ${D}/${HOMEDIR}/dspam.conf
		fi

		newins tools.ora_drv/oral_objects.sql ora_objects.sql
		newins tools.ora_drv/virtual_users.sql ora_virtual_users.sql
		newins tools.ora_drv/purge.sql ora_purge.sql
	elif use sqlite ; then
		newins tools.sqlite_drv/purge.sql sqlite_purge.sql
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

	# dspam enviroment
	echo -ne "CONFIG_PROTECT_MASK=\"${HOMEDIR}\"\n\n" > ${T}/40dspam
	doenvd ${T}/40dspam || die
}

pkg_postinst() {
	if use mysql || use mysql41 || use postgres; then
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
		[[ -f ${HOMEDIR}/mysql.data ]] && mv -f ${HOMEDIR}/mysql.data ${HOMEDIR}
		DSPAM_MySQL_USER="$(cat ${HOMEDIR}/mysql.data|head -n 3|tail -n 1)"
		DSPAM_MySQL_PWD="$(cat ${HOMEDIR}/mysql.data|head -n 4|tail -n 1)"
		DSPAM_MySQL_DB="$(cat ${HOMEDIR}/mysql.data|head -n 5|tail -n 1)"

		ewarn "When prompted for a password, please enter your MySQL root password"
		ewarn ""

		einfo "Creating DSPAM MySQL database \"${DSPAM_MySQL_DB}\""
		/usr/bin/mysqladmin -u root -p create ${DSPAM_MySQL_DB}

		if use mysql41 ; then
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${HOMEDIR}/mysql_objects-4.1.sql
		else
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
				/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${HOMEDIR}/mysql_objects-space.sql
			else
				/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${HOMEDIR}/mysql_objects-speed.sql
			fi
		fi

		einfo "Creating DSPAM MySQL database for virtual users"
		/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${HOMEDIR}/mysql_virtual_users.sql

		if use neural ; then
			/usr/bin/mysql -u root -p ${DSPAM_MySQL_DB} < ${HOMEDIR}/mysql_neural.sql
		fi

		einfo "Creating DSPAM MySQL user \"${DSPAM_MySQL_USER}\""
		/usr/bin/mysql -u root -p -e "GRANT SELECT,INSERT,UPDATE,DELETE ON ${DSPAM_MySQL_DB}.* TO ${DSPAM_MySQL_USER}@localhost IDENTIFIED BY '${DSPAM_MySQL_PWD}';FLUSH PRIVILEGES;" -D mysql
	elif use postgres ; then
		[[ -f ${HOMEDIR}/pgsql.data ]] && mv -f ${HOMEDIR}/pgsql.data ${HOMEDIR}
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
		PGUSER=${DSPAM_PgSQL_USER} PGPASSWORD=${DSPAM_PgSQL_PWD} /usr/bin/psql -d ${DSPAM_PgSQL_DB} -U ${DSPAM_PgSQL_USER} -f ${HOMEDIR}/pgsql_objects.sql 1>/dev/null 2>&1
		PGUSER=${DSPAM_PgSQL_USER} PGPASSWORD=${DSPAM_PgSQL_PWD} /usr/bin/psql -d ${DSPAM_PgSQL_DB} -U ${DSPAM_PgSQL_USER} -f ${HOMEDIR}/pgsql_virtual_users.sql 1>/dev/null 2>&1

		einfo "Grant privileges to DSPAM PostgreSQL objects to \"${DSPAM_PgSQL_USER}\""
		for foo in $(/usr/bin/psql -t -d ${DSPAM_PgSQL_DB} -U postgres -c "SELECT tablename FROM pg_tables WHERE tablename LIKE 'dspam\%';")
		do
			/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "GRANT ALL PRIVILEGES ON TABLE ${foo} TO ${DSPAM_PgSQL_USER};" 1>/dev/null 2>&1
		done
		/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE ${DSPAM_PgSQL_DB} TO ${DSPAM_PgSQL_USER};" 1>/dev/null 2>&1
		/usr/bin/psql -d ${DSPAM_PgSQL_DB} -U postgres -c "GRANT ALL PRIVILEGES ON SCHEMA public TO ${DSPAM_PgSQL_USER};" 1>/dev/null 2>&1
	elif use oci8 ; then
		[[ -f ${HOMEDIR}/oracle.data ]] && mv -f ${HOMEDIR}/oracle.data ${HOMEDIR}
	elif use sqlite ; then
		einfo "sqlite_drv will automatically create the necessary database"
		einfo "objects for each user upon first use of DSPAM by that user."
	fi

}
