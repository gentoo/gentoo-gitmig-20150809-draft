# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.14.ebuild,v 1.36 2006/04/13 12:55:40 vivo Exp $

inherit eutils gnuconfig flag-o-matic versionator

SVER=${PV%.*}
NEWP="${PN}-${PV}"
#NEWP="${NEWP/_beta/-beta}"


# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="mirror://mysql/Downloads/MySQL-${SVER}/${NEWP}.tar.gz
	mirror://gentoo/mysql-extras-20050920.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="big-tables berkdb debug doc minimal perl readline selinux ssl static tcpd"
RESTRICT="primaryuri"

DEPEND="readline? ( >=sys-libs/readline-4.1 )
	berkdb? ( sys-apps/ed )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r6 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( dev-lang/perl )
	userland_GNU? ( sys-process/procps )
	>=sys-libs/zlib-1.2.3
	>=sys-apps/texinfo-4.7-r1
	>=sys-apps/sed-4"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )"

if version_is_at_least "4.1.3" ; then
	IUSE="${IUSE} cluster utf8 geometry extraengine"
fi

mysql_upgrade_error() {
	ewarn "Sorry, plain up/downgrade between different version of MySQL is (still)"
	ewarn "un-supported."
	ewarn "Some gentoo documentation on how to do it:"
	ewarn "http://www.gentoo.org/doc/en/mysql-upgrading.xml"
	ewarn "Also on the MySQL website:"
	ewarn "http://dev.mysql.com/doc/refman/4.1/en/upgrading-from-4-0.html"
	ewarn ""
	ewarn "You can also choose to preview some new MySQL 4.1 behaviour"
	ewarn "adding a section \"[mysqld-4.0]\" followed by the word \"new\""
	ewarn "into /etc/mysql/my.cnf (you need a recent MySQL version)"
	ewarn ""

}

mysql_upgrade_warning() {
	ewarn "If you're upgrading from MySQL-3.x to 4.0, or 4.0.x to 4.1.x, you"
	ewarn "must recompile the other packages on your system that link with"
	ewarn "libmysqlclient after the upgrade completes.  To obtain such a list"
	ewarn "of packages for your system, you may use:"
	ewarn "revdep-rebuild --library=libmysqlclient.so.12"
	ewarn "from app-portage/gentoolkit."
	ewarn ""
	ewarn "the value of \"innodb_log_file_size\" into /etc/mysql/my.cnf file "
	ewarn "has changed size from \"8M\" to \"5M\"."
	ewarn "To start mysql either revert the value back to \"8M\" or backup and"
	ewarn "remove the old ib_logfile* from the datadir"
}

mysql_get_datadir() {
	DATADIR=""
	if [ -f '/etc/mysql/my.cnf' ] ; then
		#DATADIR=`/usr/sbin/mysqld  --help |grep '^datadir' | awk '{print $2}'`
		#DATADIR=`my_print_defaults mysqld | grep -- '^--datadir' | tail -n1 | sed -e 's|^--datadir=||'`
		DATADIR=`my_print_defaults mysqld 2>/dev/null | sed -ne '/datadir/s|^--datadir=||p' | tail -n1`
		if [ -z "${DATADIR}" ]; then
			DATADIR=`grep ^datadir /etc/mysql/my.cnf | sed -e 's/.*= //'`
			einfo "Using default DATADIR"
		fi
	fi
	if [ -z "${DATADIR}" ]; then
		DATADIR="/var/lib/mysql/"
		einfo "Using default DATADIR"
	fi
	einfo "MySQL DATADIR is ${DATADIR}"

	if [ -z "${PREVIOUS_DATADIR}" ] ; then
		if [ -a "${DATADIR}" ] ; then
			ewarn "Previous datadir found, it's YOUR job to change"
			ewarn "ownership and have care of it"
			PREVIOUS_DATADIR="yes"
			export PREVIOUS_DATADIR
		else
			PREVIOUS_DATADIR="no"
			export PREVIOUS_DATADIR
		fi
	fi

	export DATADIR
}

pkg_setup() {

	if [[ -z $MYSQL_STRAIGHT_UPGRADE ]] ; then
		mysql_get_datadir
		local curversion="dev-db/${PN}-${PV%.*}"
		local oldversion="$(best_version dev-db/mysql)"
		oldversion=${oldversion%.*}

		# permit upgrade from old version if it's safe
		useq minimal && oldversion=""
		built_with_use dev-db/mysql minimal && oldversion=""
		[[ -d "${DATADIR}/mysql" ]] || oldversion=""

		if [[ -n "${oldversion}" ]] && [[ "${oldversion}" != "${curversion}" ]]
		then
			mysql_upgrade_error
			eerror "MySQL-${oldversion} found, up/downgrade to \"${curversion}\" is unsupported"
			eerror "export MYSQL_STRAIGHT_UPGRADE=1 to force"
			die
		fi
	fi

	mysql_upgrade_warning

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"

}

src_unpack() {
	if useq static && useq ssl; then
		local msg="MySQL does not support building statically with SSL support"
		eerror "${msg}"
		die "${msg}"
	fi

	if version_is_at_least "4.1.3" \
	&& useq cluster \
	|| useq geometry \
	|| useq extraengine \
	&& useq minimal ; then
		die "USEs cluster, geometry, extraengine conflicts with \"minimal\""
	fi

	unpack ${A} || die

	mv "${WORKDIR}/${NEWP}" "${S}"
	cd "${S}"
	rm -rf "${S}/zlib/"*.[ch]
	sed -i -e "s/zlib\/Makefile dnl/dnl zlib\/Makefile/" "${S}/configure.in"

	local MY_PATCH_SOURCE="${WORKDIR}/mysql-extras"

	epatch ${MY_PATCH_SOURCE}/010_all_my-print-defaults-r0.patch || die
	epatch ${MY_PATCH_SOURCE}/030_all_thrssl-r1.patch || die
	epatch ${MY_PATCH_SOURCE}/035_x86_asm-pic-fixes-r7.patch || die
	epatch ${MY_PATCH_SOURCE}/040_all_tcpd-vars-fix.patch || die

	for d in ${S} ${S}/innobase; do
		cd ${d}
		# WARNING, plain autoconf breaks it!
		#autoconf
		# must use this instead
		WANT_AUTOCONF="2.59" autoreconf --force
		# Fix the evil "libtool.m4 and ltmain.sh have a version mismatch!"
		libtoolize --copy --force
		# Saving this for a rainy day, in case we need it again
		#WANT_AUTOMAKE=1.7 automake
		gnuconfig_update
	done

	# Temporary workaround for bug in test suite, a correct solution
	# should work inside the include files to enable/disable the tests
	# for the current configuration

	if ! useq extraengine ; then
		einfo "disabling unneded extraengine tests"
		local disable_test="archive bdb blackhole federated view csv"
		for i in $disable_test ; do
			mv "${S}/mysql-test/t/${i}.test" "${S}/mysql-test/t/${i}.disabled" \
			&> /dev/null
		done
	fi


	if ! useq berkdb ; then
		einfo "disabling unneded berkdb tests"
		local disable_test="auto_increment bdb-alter-table-1 bdb-alter-table-2 bdb-crash bdb-deadlock bdb bdb_cache binlog ctype_sjis ctype_utf8 heap_auto_increment index_merge_bdb multi_update mysqldump ps_1general ps_6bdb rowid_order_bdb"
		for i in $disable_test ; do
			mv "${S}/mysql-test/t/${i}.test" "${S}/mysql-test/t/${i}.disabled" \
			&> /dev/null
		done
	fi
}

src_compile() {
	local myconf

	# readline pair reads backwards on purpose, DONT change it around, Ok?
	# this is because it refers to the building of a bundled readline
	# versus the system copy
	useq readline && myconf="${myconf} --without-readline"
	useq readline || myconf="${myconf} --with-readline"

	if useq static ; then
		myconf="${myconf} --with-mysqld-ldflags=-all-static"
		myconf="${myconf} --with-client-ldflags=-all-static"
		myconf="${myconf} --disable-shared"
	else
		myconf="${myconf} --enable-shared --enable-static"
	fi

	myconf="${myconf} `use_with tcpd libwrap`"

	if useq ssl ; then
		# --with-vio is not needed anymore, it's on by default and
		# has been removed from configure
		version_is_at_least "5.0.4_beta" || myconf="${myconf} --with-vio"
		if version_is_at_least "5.0.6_beta" ; then
			# yassl-0.96 is young break with gcc-4.0 || amd64
			#myconf="${myconf} --with-yassl"
			myconf="${myconf} --with-openssl"
		else
			myconf="${myconf} --with-openssl"
		fi
	else
		myconf="${myconf} --without-openssl"
	fi

	if useq debug; then
		myconf="${myconf} --with-debug=full"
	else
		myconf="${myconf} --without-debug"
		version_is_at_least "4.1.3" && useq cluster && myconf="${myconf} --without-ndb-debug"
	fi

	# benchmarking stuff needs perl
	# and shouldn't be bothered with on minimal builds
	if useq perl && ! useq minimal; then
		myconf="${myconf} --with-bench"
	else
		myconf="${myconf} --without-bench"
	fi

	# these are things we exclude from a minimal build
	# note that the server actually does get built and installed
	# but we then delete it before packaging.
	local minimal_exclude_list="server embedded-server extra-tools innodb"
	if ! useq minimal; then
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --with-${i}"
		done

		if useq static ; then
			myconf="${myconf} --without-raid"
			ewarn "disabling raid support, has problem with static"
		else
			myconf="${myconf} --with-raid"
		fi

		if ! version_is_at_least "5.0_alpha" ; then
			if version_is_at_least "4.1_alpha" && useq utf8; then
				myconf="${myconf} --with-charset=utf8"
				myconf="${myconf} --with-collation=utf8_general_ci"
			else
				myconf="${myconf} --with-charset=latin1"
				myconf="${myconf} --with-collation=latin1_swedish_ci"
			fi
		fi

		# lots of chars
		myconf="${myconf} --with-extra-charsets=all"

		#The following fix is due to a bug with bdb on sparc's. See:
		#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
		# it comes down to non-64-bit safety problems
		if useq sparc || useq alpha || useq hppa || useq mips || useq amd64
		then
			myconf="${myconf} --without-berkeley-db"
		else
			useq berkdb \
				&& myconf="${myconf} --with-berkeley-db=./bdb" \
				|| myconf="${myconf} --without-berkeley-db"
		fi

		if version_is_at_least "4.1.3" ; then
			myconf="${myconf} $(use_with geometry)"
			myconf="${myconf} $(use_with cluster ndbcluster)"
		fi

		version_is_at_least "4.1.11_alpha20050403" &&  myconf="${myconf} --with-big-tables"
	else
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --without-${i}"
		done
		myconf="${myconf} --without-berkeley-db"
		myconf="${myconf} --with-extra-charsets=none"
	fi

	# documentation
	myconf="${myconf} `use_with doc docs`"

	if version_is_at_least "4.1.3" && useq extraengine; then
		# http://dev.mysql.com/doc/mysql/en/archive-storage-engine.html
		myconf="${myconf} --with-archive-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/csv-storage-engine.html
		version_is_at_least "4.1.4" \
		&& myconf="${myconf} --with-csv-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/federated-description.html
		# http://dev.mysql.com/doc/mysql/en/federated-limitations.html
		if version_is_at_least "5.0.3" ; then
			einfo "before to use federated engine be sure to read"
			einfo "http://dev.mysql.com/doc/mysql/en/federated-limitations.html"
			myconf="${myconf} --with-federated-storage-engine"
		fi
		version_is_at_least "4.1.11_alpha20050403" \
		&&  myconf="${myconf} --with-blackhole-storage-engine"
	fi

	myconf="${myconf} `use_with big-tables`"

	#glibc-2.3.2_pre fix; bug #16496
	append-flags "-DHAVE_ERRNO_AS_DEFINE=1"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	export CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti"
	version_is_at_least "5.0_alpha" \
	&& export CXXFLAGS="${CXXFLAGS} -fno-implicit-templates"

	econf \
		--libexecdir=/usr/sbin \
		--sysconfdir=/etc/mysql \
		--localstatedir=/var/lib/mysql \
		--with-low-memory \
		--enable-assembler \
		--enable-local-infile \
		--with-mysqld-user=mysql \
		--with-client-ldflags=-lstdc++ \
		--enable-thread-safe-client \
		--with-comment="Gentoo Linux ${PF}" \
		--with-unix-socket-path=/var/run/mysqld/mysqld.sock \
		--with-lib-ccflags="-fPIC" \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_test() {
	cd ${S}
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq minimal; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI

		# Temporary removed, 4.1.14 use mysql-test-run.pl instead
		# of mysql-test-run, thus failing on test that should be
		# skipped.
		#version_is_at_least "5.0.6_beta" \
		#&& make test-force \
		#|| make test

		# <replace me whenever possible>
		cd mysql-test; ./mysql-test-run && ./mysql-test-run --ps-protocol
		retstatus=$?
		cd ..
		# </replace me whenever possible>

		# to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}

src_install() {
	mysql_get_datadir
	make install DESTDIR="${D}" benchdir_root="/usr/share/mysql" || die

	# move client libs, install a couple of missing headers
	local lib=$(get_libdir)
	mv ${D}/usr/${lib}/mysql/libmysqlclient*.so* ${D}/usr/${lib}
	dosym ../libmysqlclient.so /usr/${lib}/mysql/libmysqlclient.so
	dosym ../libmysqlclient_r.so /usr/${lib}/mysql/libmysqlclient_r.so
	insinto /usr/include/mysql ; doins include/{my_config.h,my_dir.h}

	# convenience links
	dosym /usr/bin/mysqlcheck /usr/bin/mysqlanalyze
	dosym /usr/bin/mysqlcheck /usr/bin/mysqlrepair
	dosym /usr/bin/mysqlcheck /usr/bin/mysqloptimize

	# various junk
	rm -f ${D}/usr/bin/make*distribution
	rm -f ${D}/usr/share/mysql/make_*_distribution
	rm -f ${D}/usr/share/mysql/mysql.server
	rm -f ${D}/usr/share/mysql/binary-configure
	rm -f ${D}/usr/share/mysql/mysql-log-rotate
	rm -f ${D}/usr/share/mysql/{post,pre}install
	rm -f ${D}/usr/share/mysql/mi_test*
	rm -f ${D}/usr/share/mysql/*.spec # Redhat gunk
	rm -f ${D}/usr/share/mysql/*.plist # Apple gunk
	rm -f ${D}/usr/share/mysql/my-*.cnf # Put them elsewhere

	# All of these (ab)use Perl.
	if ! useq perl; then
		rm -f ${D}/usr/bin/{mysqlhotcopy,mysql_find_rows,mysql_convert_table_format,mysqld_multi,mysqlaccess,mysql_fix_extensions,mysqldumpslow,mysql_zap,mysql_explain_log,mysql_tableinfo,mysql_setpermission}
		rm -f ${D}/usr/bin/mysqlhotcopy
		rm -rf ${D}/usr/share/mysql/sql-bench
	fi

	# clean up stuff for a minimal build
	# this is anything server-specific
	if useq minimal; then
		rm -rf ${D}/usr/share/mysql/{mysql-test,sql-bench}
		rm -f ${D}/usr/bin/{mysql_install_db,mysqlmanager*,mysql_secure_installation,mysql_fix_privilege_tables,mysqlhotcopy,mysql_convert_table_format,mysqld_multi,mysql_fix_extensions,mysql_zap,mysql_explain_log,mysql_tableinfo,mysqld_safe,myisam*,isam*,mysql_install,mysql_waitpid,mysqlbinlog,mysqltest,pack_isam}
		rm -f ${D}/usr/sbin/mysqld
		rm -f ${D}/usr/lib/mysql/lib{heap,merge,nisam,mysys,mystrings,mysqld,myisammrg,vio,dbug,myisam}.a
	fi

	# config stuff
	insinto /etc/mysql
	doins scripts/mysqlaccess.conf

	newins "${FILESDIR}/my.cnf-4.1" my.cnf

	if version_is_at_least "4.1.3" && ! useq utf8; then
		sed --in-place -e "s/utf8/latin1/" \
			${D}/etc/mysql/my.cnf
	fi

	# minimal builds don't have the server
	if ! useq minimal; then
		exeinto /etc/init.d
		newexe "${FILESDIR}/mysql-4.0.24-r2.rc6" mysql
		insinto /etc/logrotate.d
		newins "${FILESDIR}/logrotate.mysql" mysql

		#empty dirs...
		diropts "-m0750"
		if [[ "${PREVIOUS_DATADIR}" != "yes" ]] ; then
			dodir "${DATADIR}"
			keepdir "${DATADIR}"
			chown -R mysql:mysql "${D}/${DATADIR}"
		fi

		diropts "-m0755"
		dodir "/var/log/mysql"
		#touch ${D}/var/log/mysql/mysql.{log,err}
		#chmod 0660 ${D}/var/log/mysql/mysql.{log,err}
		keepdir "/var/log/mysql"
		chown -R mysql:mysql "${D}/var/log/mysql"

		diropts "-m0755"
		dodir "/var/run/mysqld"

		keepdir "/var/run/mysqld"
		chown -R mysql:mysql "${D}/var/run/mysqld"
	fi

	# docs
	dodoc README COPYING ChangeLog EXCEPTIONS-CLIENT INSTALL-SOURCE
	# minimal builds don't have the server
	if useq doc && ! useq minimal; then
		dohtml Docs/*.html
		dodoc Docs/manual.{txt,ps}
		docinto conf-samples
		dodoc support-files/my-*.cnf
	fi
}

pkg_preinst() {
	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

pkg_postinst() {
	mysql_get_datadir

	# mind at FEATURES=collision-protect before to remove this
	#empty dirs...
	[ -d "${ROOT}/var/log/mysql" ] \
		|| install -d -m0755 -o mysql -g mysql ${ROOT}/var/log/mysql

	#secure the logfiles... does this bother anybody?
	touch ${ROOT}/var/log/mysql/mysql.{log,err}
	chown mysql:mysql ${ROOT}/var/log/mysql/mysql*
	chmod 0660 ${ROOT}/var/log/mysql/mysql*
	# secure some directories
	chmod 0750 ${ROOT}/var/log/mysql

	if ! useq minimal; then
		# your friendly public service announcement...
		einfo
		einfo "You might want to run:"
		einfo "\"emerge --config =${PF}\""
		einfo "if this is a new install."
		einfo
	fi

	mysql_upgrade_warning
	einfo "InnoDB is not optional as of MySQL-4.0.24, at the request of upstream."
}

pkg_config() {
	mysql_get_datadir

	if built_with_use dev-db/mysql minimal; then
		die "Minimal builds do NOT include the MySQL server"
	fi

	if [[ "$(pgrep mysqld)" != "" ]] ; then
		die "Oops you already have a mysql daemon running!"
	fi

	local pwd1="a"
	local pwd2="b"
	local maxtry=5

	if [[ -d "${ROOT}/${DATADIR}/mysql" ]] ; then
		ewarn "You have already a MySQL database in place."
		ewarn "Please rename it or delete it if you wish to replace it."
		die "MySQL database already exists!"
	fi

	einfo "Creating the mysql database and setting proper"
	einfo "permissions on it..."

	einfo "Insert a password for the mysql 'root' user"
	ewarn "Avoid [\"'\\_%] characters in the password"

	read -rsp "    >" pwd1 ; echo
	einfo "Check the password"
	read -rsp "    >" pwd2 ; echo

	if [[ "x$pwd1" != "x$pwd2" ]] ; then
		die "Passwords are not the same"
	fi

	${ROOT}/usr/bin/mysql_install_db || die "MySQL databases not installed"

	# MySQL 5.0 don't need this
	chown -R mysql:mysql ${ROOT}/${DATADIR}
	chmod 0750 ${ROOT}/${DATADIR}

	local options=""
	local sqltmp="$(emktemp)"
	local help_tables="${ROOT}/usr/share/mysql/fill_help_tables.sql"

	if version_is_at_least "4.1.3" ; then
		options="--skip-ndbcluster"

		# Filling timezones, see
		# http://dev.mysql.com/doc/mysql/en/time-zone-support.html
		${ROOT}/usr/bin/mysql_tzinfo_to_sql ${ROOT}/usr/share/zoneinfo \
		> "${sqltmp}"

		if [[ -r "${help_tables}" ]] ; then
			cat "${help_tables}" >> "${sqltmp}"
		fi
	fi

	local socket=${ROOT}/var/run/mysqld/mysqld.sock
	local mysqld="${ROOT}/usr/sbin/mysqld \
		${options} \
		--skip-grant-tables \
		--basedir=${ROOT}/usr \
		--datadir=${ROOT}/${DATADIR} \
		--skip-innodb \
		--skip-bdb \
		--max_allowed_packet=8M \
		--net_buffer_length=16K \
		--socket=${socket} \
		--pid-file=${ROOT}/var/run/mysqld/mysqld.pid"

	$mysqld &
	while ! [[ -S "${socket}" || "${maxtry}" -lt 1 ]]
	do
		maxtry=$(($maxtry-1))
		echo -n "."
		sleep 1
	done

	# do this from memory we don't want clear text password in temp files
	local sql="UPDATE mysql.user SET Password = PASSWORD('${pwd1}') WHERE USER='root'"
	${ROOT}/usr/bin/mysql \
		--socket=${ROOT}/var/run/mysqld/mysqld.sock \
		-hlocalhost \
		-e "${sql}"

	einfo "Loading \"zoneinfo\" this step may require few seconds"

	${ROOT}/usr/bin/mysql \
		--socket=${socket} \
		-hlocalhost \
		-uroot \
		-p"${pwd1}" \
		mysql < "${sqltmp}"

	kill $( cat ${ROOT}/var/run/mysqld/mysqld.pid )
	rm  "${sqltmp}"
	einfo "done"
}
