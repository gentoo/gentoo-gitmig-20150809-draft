# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dspam/dspam-3.1.0.ebuild,v 1.6 2004/10/24 15:08:56 st_lim Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A statistical-algorithmic hybrid anti-spam filter"
SRC_URI="http://www.nuclearelephant.com/projects/dspam/sources/${P}.tar.gz"
HOMEPAGE="http://www.nuclearelephant.com/projects/dspam/index.html"
LICENSE="GPL-2"

IUSE="cyrus debug exim mysql maildrop neural postgres procmail"
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

MYSQL_TABLE_TYPE="space.optimized"

pkg_setup() {
	if use mysql && use postgres; then
		echo
		ewarn "You have both \"mysql\" and \"postgres\" in your USE flags."
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
	myconf="${myconf} --enable-homedir-dotfiles"
	myconf="${myconf} --enable-spam-subject"
	myconf="${myconf} --enable-chi-square"
	myconf="${myconf} --enable-robinson"
	myconf="${myconf} --enable-robinson-pvalues"
	myconf="${myconf} --enable-source-address-tracking"

	# ${HOMEDIR}/data is a symlink to ${DATADIR}
	myconf="${myconf} --with-dspam-home=${HOMEDIR}"
	myconf="${myconf} --with-dspam-mode=4755"
	myconf="${myconf} --with-dspam-owner=dspam"
	myconf="${myconf} --with-dspam-group=dspam"
	myconf="${myconf} --with-dspam-home-owner=dspam"
	myconf="${myconf} --with-dspam-home-group=dspam"

	# enables support for debugging (touch /etc/dspam/.debug to turn on)
	# optional: even MORE debugging output, use with extreme caution!
	use debug && myconf="${myconf} --enable-debug --enable-verbose-debug"

	# select storage driver
	if use mysql ; then
		myconf="${myconf} --with-storage-driver=mysql_drv"
		myconf="${myconf} --with-mysql-includes=/usr/include/mysql"
		myconf="${myconf} --with-mysql-libraries=/usr/lib/mysql"
		myconf="${myconf} --with-client-compression"

		# an experimental feature available with MySQL backend
		if use neural ; then
			myconf="${myconf} --enable-neural-networking"
		fi
	elif use postgres ; then
		myconf="${myconf} --with-storage-driver=pgsql_drv"
		myconf="${myconf} --with-pgsql-includes=/usr/include/postgresql"
		myconf="${myconf} --with-pgsql-libraries=/usr/lib/postgresql"

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
	fi

	# install some initial configuration
	insinto ${HOMEDIR}
	insopts -m0664 -o dspam -g dspam
	[ -f ${HOMEDIR}/trusted.users ] || doins ${FILESDIR}/trusted.users
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

	# database related configuration and scripts
	if use mysql ; then
		local PASSWORD="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"

		# Replace some variables in the configuration files
		sed -e "s,@HOMEDIR@,${HOMEDIR},g" \
			-e "s,@confdir@,${CONFIGDIR},g" \
			${FILESDIR}/crontab.mysql > ${T}/dspam.cron

		sed -e "s,@password@,${PASSWORD},g" \
			${FILESDIR}/mysql.data > ${T}/mysql.data

		sed -e "s,@password@,${PASSWORD},g" \
			${FILESDIR}/mysql_create_user.sql > ${T}/mysql_setup.sql
		cat ${S}/tools.mysql_drv/mysql_objects.sql.${MYSQL_TABLE_TYPE} >> ${T}/mysql_setup.sql

		sed -e "s,@HOMEDIR@,${HOMEDIR},g" \
			-e "s,@confdir@,${CONFIGDIR},g" \
			${FILESDIR}/mysql_install_db > ${T}/mysql_install_db

		sed -e "s,@HOMEDIR@,${HOMEDIR},g" \
			-e "s,@password@,${PASSWORD},g" \
			-e "s,@confdir@,${CONFIGDIR},g" \
			 ${FILESDIR}/mysql_purge_db > ${T}/mysql_purge_db

		insinto ${CONFIGDIR}
		insopts -m644 -o dspam -g dspam
		doins ${T}/mysql.data
		doins ${T}/mysql_setup.sql
		doins ${FILESDIR}/upgrade.sql
		newins tools.mysql_drv/purge.sql mysql_purge.sql

		exeinto ${CONFIGDIR}
		exeopts -m755 -o dspam -g dspam
		doexe ${T}/mysql_install_db
		doexe ${T}/mysql_purge_db

		einfo "Fresh install: run ${HOMEDIR}/mysql_install_db to setup the dspam database"
		einfo "Upgrades from 2.x: See the README for instructions on updating your tables for dspam-3.0"
	elif use postgres ; then
		local PASSWORD="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"

		# Replace some variables in the configuration files
		sed -e "s,@HOMEDIR@,${HOMEDIR},g" \
			-e "s,@confdir@,${CONFIGDIR},g" \
			${FILESDIR}/crontab.mysql > ${T}/dspam.cron

		sed -e "s,@HOSTNAME@,127.0.0.1,g" \
			-e "s,@PORT@,5432,g" \
			-e "s,@USERNAME@,dspam,g" \
			-e "s,@PASSWORD@,${PASSWORD},g" \
			-e "s,@DATABASE@,dspam,g" \
			${FILESDIR}/pgsql.data > ${T}/pgsql.data

		cat ${S}/tools.pgsql_drv/pgsql_objects.sql >> ${T}/pgsql_setup.sql

		sed -e "s,@HOMEDIR@,${HOMEDIR},g" \
			-e "s,@password@,${PASSWORD},g" \
			-e "s,@confdir@,${CONFIGDIR},g" \
			-e "s,mysql_purge,pgsql_purge,g" \
			 ${FILESDIR}/mysql_purge_db > ${T}/pgsql_purge_db

		insinto ${CONFIGDIR}
		insopts -m644 -o dspam -g dspam
		doins ${T}/pgsql.data
		doins ${T}/pgsql_setup.sql
		doins ${FILESDIR}/upgrade.sql
		newins tools.pgsql_drv/purge.sql pgsql_purge.sql

		exeinto ${CONFIGDIR}
		exeopts -m755 -o dspam -g dspam
		doexe ${T}/pgsql_purge_db

		einfo "Fresh install: You need to set up and install a database called dspam,"
		einfo "create a user called dspam with rights to the database, and password "
		einfo "'${PASSWORD}', and then install ${CONFIGDIR}/pgsql_setup.sql on your "
		einfo "Postgres installation"
	else
		cp ${FILESDIR}/crontab.db4 ${T}/dspam.cron
	fi

	# installs the cron job to the cron directory
	diropts -m0755 -o dspam -g dspam
	dodir /etc/cron.daily
	keepdir /etc/cron.daily
	exeinto /etc/cron.daily
	exeopts -m0755 -o dspam -g dspam
	doexe ${T}/dspam.cron

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
	touch ${D}${LOGDIR}/sql.errors
	touch ${D}${LOGDIR}/system.log
	touch ${D}${LOGDIR}/dspam.debug
	touch ${D}${LOGDIR}/dspam.messages

	# dspam still wants to write to a few files in it's home dir
	dosym ${LOGDIR}/sql.errors ${HOMEDIR}/sql.errors
	dosym ${LOGDIR}/system.log ${HOMEDIR}/system.log
	dosym ${LOGDIR}/dspam.debug ${HOMEDIR}/dspam.debug
	dosym ${LOGDIR}/dspam.messages ${HOMEDIR}/dspam.messages
}

pkg_postinst() {
	if use mysql ; then
		einfo "To setup dspam to run out-of-the-box on your system with a mysql database, run:"
		einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	fi
	if use exim ; then
		echo
		einfo "To use dspam in conjunction with your exim system, you should read the README"
	fi
}

pkg_config () {
	if use mysql ; then
		${CONFIGDIR}/mysql_install_db
		mv ${CONFIGDIR}/mysql.data ${HOMEDIR}
	fi
}
