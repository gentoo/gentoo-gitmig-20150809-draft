# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/bacula/bacula-1.36.3.ebuild,v 1.1 2005/07/01 11:59:04 iggy Exp $

inherit eutils

DESCRIPTION="featureful client/server network backup suite"
HOMEPAGE="http://www.bacula.org/"
SRC_URI="mirror://sourceforge/bacula/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="bacula-clientonly bacula-console bacula-split doc gnome logrotate logwatch mysql postgres readline sqlite static tcpd wxwindows X"

#theres a local sqlite use flag. use it -OR- mysql, not both.
#mysql is the reccomended choice ...
#may need sys-libs/libtermcap-compat but try without first
DEPEND="
	>=sys-libs/zlib-1.1.4
	dev-libs/gmp
	!bacula-clientonly? (
		mysql? ( >=dev-db/mysql-3.23 )
		postgres? ( >=dev-db/postgresql-7.4.0 )
		sqlite? ( =dev-db/sqlite-2* )
		!mysql? ( !postgres? ( !sqlite? ( >=dev-db/mysql-3.23 ) ) )
		virtual/mta
	)
	bacula-console? (
		X? ( virtual/x11 )
		wxwindows? ( >=x11-libs/wxGTK-2.4.2 )
		gnome? ( gnome-base/libgnome )
		gnome? ( app-admin/gnomesu )
	)
	doc? (
		app-text/tetex
		dev-tex/latex2html
	)
	logrotate? ( app-admin/logrotate )
	logwatch? ( sys-apps/logwatch )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	readline? ( >=sys-libs/readline-4.1 )"
RDEPEND="${DEPEND}
	!bacula-clientonly? (
		sys-block/mtx
		app-arch/mt-st
	)"

pkg_setup() {
	if ( use mysql || use postgres ) && [ -z ${BACULA_DB_USER} ] && [ -z ${BACULA_DB_PASSWORD} ] && [ -z ${BACULA_DB_HOST} ]; then
		# Display warning about DB query environment variables
		einfo
		einfo "If you are upgrading or rebuilding your bacula installation and"
		einfo "your database requires you to specify user, password, or host"
		einfo "you may do so with the environment variables BACULA_DB_USER,"
		einfo "BACULA_DB_PASSWORD, and BACULA_DB_HOST respectively."
		einfo
		einfo "For example:"
		einfo "# export BACULA_DB_USER=\"bacula\""
		einfo "# export BACULA_DB_PASSWORD=\"mydbpassword\""
		einfo "# export BACULA_DB_HOST=\"mydbhost.mydomain.net\""
		einfo "# emerge bacula"
		einfo
		einfo "If you require these variables and have not set them yet, you"
		einfo "may wish to abort now and do so.  If this is a new installation"
		einfo "of bacula, this should not affect you."
		einfo

		ebeep 3
		ewarn "Press Ctrl-C to abort.  Merge will resume in 10 seconds."
		epause 10
	fi
}

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	# this resolves bacula bug #181
	epatch ${FILESDIR}/${PN}-1.36.2-cdrecord-configure.patch
	# fixes lack of depend() in split init scripts
	epatch ${FILESDIR}/${PN}-1.36.3-init-depends.patch
	# adds build/install capability to ${S}/rescue/linux/Makefile.in
	epatch ${FILESDIR}/${PN}-1.36.3-rescue-makefile.patch
	cd ${S}
}

src_compile() {
	local myconf=""
	if use bacula-clientonly ; then
		myconf="${myconf}
			`use_enable bacula-clientonly client-only`
			`use_enable static static-fd`"
	fi
	if use bacula-console ; then
		myconf="${myconf}
			`use_enable X x`
			`use_enable gnome tray-monitor`
			`use_enable wxwindows wx-console`
			`use_enable static static-cons`"
	fi
	myconf="${myconf}
		`use_enable readline`
		`use_enable tcpd tcp-wrappers`"

	# select database support
	if ! use bacula-clientonly; then
		if ! use mysql && ! use postgres && ! use sqlite ; then
			ewarn "No database enabled in USE."
			ewarn "Using mysql database support by default."
			myconf="${myconf}
				`use_with mysql`"
		elif use mysql ; then
			if use postgres ; then
				ewarn "Multiple databases enabled in USE."
				ewarn "Using mysql database support by default."
			elif use sqlite ; then
				ewarn "Multiple databases enabled in USE."
				ewarn "Using mysql database support by default."
			fi
			myconf="${myconf}
				`use_with mysql`"
		elif use postgres ; then
			if use sqlite ; then
				ewarn "Multiple databases enabled in USE."
				ewarn "Using postgresql database support by default."
			fi
			myconf="${myconf}
				`use_with postgres postgresql`"
		else
			myconf="${myconf}
				`use_with sqlite`"
		fi
	fi
	if ! use bacula-clientonly; then
		if use static ; then
			myconf="${myconf}
				`use_enable static static-tools`
				`use_enable static static-fd`
				`use_enable static static-sd`
				`use_enable static static-dir`"
		fi
	fi

	./configure \
		--prefix=/usr \
		--enable-smartalloc \
		--mandir=/usr/share/man \
		--with-pid-dir=/var/run \
		--sysconfdir=/etc/bacula \
		--infodir=/usr/share/info \
		--with-subsys-dir=/var/lock/subsys \
		--with-working-dir=/var/bacula \
		--with-scriptdir=/etc/bacula \
		--with-dir-user=root \
		--with-dir-group=bacula \
		--with-sd-user=root \
		--with-sd-group=bacula \
		--with-fd-user=root \
		--with-fd-group=bacula \
		--host=${CHOST} ${myconf} || die "Configure failed!"

	emake || die "Failed primary build!"

	if use doc ; then
		# make the docs
		cd ${S}/doc/latex && emake || die "Failed to build tetx docs!" && cd ${S}
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "Failed install to ${D} !"

	if use gnome ; then
		dodir /usr/bin
		emake DESTDIR=${D} \
			install-menu \
			install-menu-xsu \
			install-menu-consolehelper || die "Failed to install gnome menu files to ${D} !"

		#chmod 755 ${D}/usr/sbin/bacula-tray-monitor
		#chmod 644 ${D}/etc/bacula/tray-monitor.conf
	fi
	if ! use bacula-clientonly ; then
		# the database update scripts
		mkdir -p ${D}/etc/bacula/updatedb
		cp ${S}/updatedb/* ${D}/etc/bacula/updatedb/
		chmod 754 ${D}/etc/bacula/updatedb/*

		# the logrotate configuration
		if use logrotate ; then
			mkdir -p ${D}/etc/logrotate.d
			cp ${S}/scripts/logrotate ${D}/etc/logrotate.d/bacula
			chmod 644 ${D}/etc/logrotate.d/bacula
		fi

		# the logwatch scripts
		if use logwatch ; then
			cd ${S}/scripts/logwatch
			emake DESTDIR=${D} install || die "Failed to install logwatch scripts to ${D} !"
			cd ${S}
		fi
	fi
	# documentation
	for a in ${S}/{Changelog,LICENSE,README,ReleaseNotes,kernstodo,doc/BaculaRoadMap_*.pdf}
	do
		dodoc ${a}
	done
	# clean up permissions left broken by install
	chown -R root:root ${D}/usr/share/doc/${PF}
	chmod -R 644 ${D}/usr/share/doc/${PF}/*
	chmod o-r ${D}/etc/bacula/query.sql
	# remove the working dir so we can add it postinst with group
	rmdir ${D}/var/bacula

	exeinto ${S}/etc/init.d
	if use bacula-clientonly ; then
		newexe ${S}/platforms/gentoo/bacula-fd bacula-fd
	else
		if use bacula-split ; then
			newexe ${S}/platforms/gentoo/bacula-fd bacula-fd
			newexe ${S}/platforms/gentoo/bacula-sd bacula-sd
			newexe ${S}/platforms/gentoo/bacula-dir bacula-dir
		else
			newexe ${S}/platforms/gentoo/bacula-init bacula
		fi
	fi
}

pkg_postinst() {
	# create the daemon group
	HAVE_BACULA=`cat /etc/group | grep bacula 2>/dev/null`
	if [ -z ${HAVE_BACULA} ]; then
		enewgroup bacula
		einfo "The group bacula has been created. Any users you add to"
		einfo "this group have access to files created by the daemons."
		# the working directory
		install -m0750 -o root -g bacula -d ${ROOT}/var/bacula
	fi

	einfo
	einfo "The CD-ROM rescue disk package has been installed into the"
	einfo "/etc/bacula/rescue/cdrom/ directory. Please examine the manual"
	einfo "for information on creating a rescue CD."
	einfo

	if ! use bacula-clientonly ; then
		# test for an existing database
		if use mysql ; then
			mydb="mysql"
		elif use postgres ; then
			mydb="postgresql"
		elif use sqlite ; then
			mydb="sqlite"
		else
			mydb="mysql"
		fi

		if [ ${mydb} == "sqlite" ]; then
			DB_VER=`echo "select * from Version;" | sqlite /var/bacula/bacula.db | tail -n 1 2>/dev/null`
		else
			if [ -z ${BACULA_DB_USER} ] && [ -z ${BACULA_DB_PASSWORD} ] && [ -z ${BACULA_DB_HOST} ]; then
				if [ ${mydb} == "mysql" ]; then
					DB_VER=`mysql bacula -e 'select * from Version;' | tail -n 1 2>/dev/null`
				elif [ ${mydb} == "postgresql" ]; then
					DB_VER=`echo 'select * from Version;' | psql bacula | tail -3 | head -n 1 2>/dev/null`
				fi
			else
				BACULA_DB_OPTS=""
				if [ ${mydb} == "mysql" ]; then
					if [ ! -z ${BACULA_DB_HOST} ]; then
						BACULA_DB_OPTS="${BACULA_DB_OPTS} --host=${BACULA_DB_HOST}"
					fi
					if [ ! -z ${BACULA_DB_USER} ]; then
						BACULA_DB_OPTS="${BACULA_DB_OPTS} --user=${BACULA_DB_USER}"
					fi
					if [ ! -z ${BACULA_DB_PASSWORD} ]; then
						BACULA_DB_OPTS="${BACULA_DB_OPTS} --password=${BACULA_DB_PASSWORD}"
					fi
					DB_VER=`mysql ${BACULA_DB_OPTS} -e 'select * from Version' bacula | tail -n 1 2>/dev/null`
				elif [ ${mydb} == "postgresql" ]; then
					if [ ! -z ${BACULA_DB_HOST} ]; then
						BACULA_DB_OPTS="${BACULA_DB_OPTS} --host ${BACULA_DB_HOST}"
					fi
					if [ ! -z ${BACULA_DB_USER} ]; then
						BACULA_DB_OPTS="${BACULA_DB_OPTS} --username ${BACULA_DB_USER}"
					fi
					# psql prompts for password by default but we can force it.
					# psql(1) does not seem to support --password=somepass
					# NOTE: this is untested
					if [ ! -z ${BACULA_DB_PASSWORD} ]; then
						BACULA_DB_OPTS="${BACULA_DB_OPTS} --password"
					fi
					DB_VER=`echo 'select * from Version;' | psql ${BACULA_DB_OPTS} bacula | tail -3 | head -n 1 2>/dev/null`
				fi
			fi
		fi
		if [ -z "${DB_VER}" ]; then
			einfo "This appears to be a new install and you plan to use ${mydb}"
			einfo "for your catalog database. You should now create it with the"
			einfo "following commands:"
			einfo " sh /etc/bacula/grant_${mydb}_privileges"
			einfo " sh /etc/bacula/create_${mydb}_database"
			einfo " sh /etc/bacula/make_${mydb}_tables"
		elif [ "${DB_VER}" -lt "8" ]; then
			einfo "This release requires an upgrade to your bacula database"
			einfo "as the database format has changed.  Please read the"
			einfo "manual chapter for upgrading your database!"
		fi
	fi

	einfo
	einfo "Configuration files are installed in /etc/bacula and"
	einfo "init script(s) are:"
	if use bacula-clientonly ; then
		einfo " /etc/init.d/bacula-fd"
	else
		if use bacula-split ; then
			einfo " /etc/init.d/bacula-sd"
			einfo " /etc/init.d/bacula-dir"
			einfo " /etc/init.d/bacula-fd"
			einfo " or /etc/bacula/bacula will start all three."
		else
			einfo " /etc/init.d/bacula"
		fi
	fi
	einfo
}
