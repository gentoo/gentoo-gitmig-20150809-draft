# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.13-r1.ebuild,v 1.4 2005/08/18 00:47:43 vivo Exp $

inherit eutils gnuconfig flag-o-matic versionator

SVER=${PV%.*}
PLV=""
NEWP="${PN}-${SVER}.$( get_version_component_range 3-3 )${PLV}"

# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="mirror://mysql/Downloads/MySQL-${SVER}/${NEWP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ia64 ~ppc ~ppc64"
IUSE="berkdb debug doc minimal perl readline selinux ssl static tcpd cluster utf8 geometry extraengine big-tables"
RESTRICT="primaryuri"

DEPEND="readline? ( >=sys-libs/readline-4.1 )
		bdb? ( sys-apps/ed )
		tcpd? ( >=sys-apps/tcp-wrappers-7.6-r6 )
		ssl? ( >=dev-libs/openssl-0.9.6d )
		perl? ( dev-lang/perl )
		>=sys-libs/zlib-1.2.3
		>=sys-apps/texinfo-4.7-r1
		sys-process/procps
		>=sys-apps/sed-4"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )"

mysql_upgrade_error() {
	mysql_get_datadir
	ewarn "Sorry plain upgrade from version of MySQL before 4.1.4 is NOT supported."
	ewarn "Be sure to read \"Upgrading from version 4.0 to 4.1\" section"
	ewarn "http://dev.mysql.com/doc/mysql/en/upgrading-from-4-0.html"
	ewarn "then unmerge previous version of MySQL with"
	ewarn "#emerge -C dev-db/mysql"
	ewarn "move your data out of \"${DATADIR}\""
	ewarn "#emerge =dev-db/${P}"
	ewarn "reload data you dumped with \"mysqldump\" Because you have read "
	ewarn "the documentation on how to upgrade"
	ewarn ""
	ewarn "You can also choose to preview some new MySQL 4.1 behaviour"
	ewarn "adding a section \"[mysqld-4.0]\" followed by the word \"new\""
	ewarn "into /etc/mysql/my.cnf (you need a recent MySQL version)"
}

mysql_upgrade_warning() {
	ewarn "If you're upgrading from MySQL-3.x to 4.0, or 4.0.x to 4.1.x, you"
	ewarn "must recompile the other packages on your system that link with"
	ewarn "libmysqlclient after the upgrade completes.  To obtain such a list"
	ewarn "of packages for your system, you may use 'revdep-rebuild' from"
	ewarn "app-portage/gentoolkit."
}

mysql_get_datadir() {
	DATADIR=""
	if [ -f '/etc/mysql/my.cnf' ] ; then
		#DATADIR=`grep ^datadir /etc/mysql/my.cnf | sed -e 's/.*= //'`
		#DATADIR=`/usr/sbin/mysqld  --help |grep '^datadir' | awk '{print $2}'`
		#DATADIR=`my_print_defaults mysqld | grep -- '^--datadir' | tail -n1 | sed -e 's|^--datadir=||'`
		DATADIR=`my_print_defaults mysqld 2>/dev/null | sed -ne '/datadir/s|^--datadir=||p' | tail -n1`
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
	mysql_get_datadir
	if ! useq minimal ; then
		if has_version "<=dev-db/mysql-4.1.4" \
		&& ! built_with_use dev-db/mysql minimal \
		&& [ -d "${DATADIR}/mysql" ]; then
			mysql_upgrade_error
			die
		fi
	fi
	mysql_upgrade_warning
}

src_unpack() {
	if use static && use ssl; then
		local msg="MySQL does not support building statically with SSL support"
		eerror "${msg}"
		die "${msg}"
	fi

	if useq cluster || useq geometry || useq extraengine && useq minimal; then
		die "USEs cluster, geometry, extraengine conflicts with \"minimal\""
	fi

	unpack ${A} || die

	mv "${WORKDIR}/${NEWP}" "${S}"
	cd "${S}"

	# for correct hardcoded sysconf directory
	epatch "${FILESDIR}/${PN}-4.0-my-print-defaults.diff"

	# attempt to get libmysqlclient_r linked against ssl if USE="ssl" enabled
	# i would really prefer to fix this at the Makefile.am level, but can't
	# get the software to autoreconf as distributed - too many missing files
	epatch "${FILESDIR}/${PN}-4.1.9-thrssl.patch"

	# PIC fixes
	# bug #42968
	epatch "${FILESDIR}/035_x86_asm-pic-fixes-r1.patch"

	if use tcpd; then
		epatch "${FILESDIR}/${PN}-4.0.14-r1-tcpd-vars-fix.diff"
	fi

	# avoid error running src_test and not enabling geometry USE flag
	useq geometry || epatch "${FILESDIR}/${PN}-test-myisam-geometry.patch"

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

	## Should be fixed in 4.1.12
	# upstream bug http://bugs.mysql.com/bug.php?id=7971
	# names conflict with stuff in 2.6.10 kernel headers
	#sed -i.orig \
	#	-e "s/\<set_bit\>/my__set_bit/g" \
	#	-e "s/\<clear_bit\>/my__clear_bit/g" \
	#	${S}/client/mysqltest.c || die "Failed to fix bitops"

}

src_compile() {
	local myconf

	# readline pair reads backwards on purpose, DONT change it around, Ok?
	# this is because it refers to the building of a bundled readline
	# versus the system copy
	use readline && myconf="${myconf} --without-readline"
	use readline || myconf="${myconf} --with-readline"

	use static \
		&& myconf="${myconf} --with-mysqld-ldflags=-all-static --disable-shared" \
		|| myconf="${myconf} --enable-shared --enable-static"

	myconf="${myconf} `use_with tcpd libwrap`"

	use ssl \
		&& myconf="${myconf} --with-vio --with-openssl" \
		|| myconf="${myconf} --without-openssl"

	if use debug; then
		myconf="${myconf} --with-debug=full"
	else
		myconf="${myconf} --without-debug"
		use cluster && myconf="${myconf} --without-ndb-debug"
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
	local minimal_exclude_list="server embedded-server extra-tools innodb raid"
	if ! useq minimal; then
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --with-${i}"
		done

		if useq utf8; then
			myconf="${myconf} --with-charset=utf8 --with-collation=utf8_general_ci"
		else
			myconf="${myconf} --with-charset=latin1 --with-collation=latin1_swedish_ci"
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
			use berkdb \
				&& myconf="${myconf} --with-berkeley-db=./bdb" \
				|| myconf="${myconf} --without-berkeley-db"
		fi
		myconf="${myconf} $(use_with geometry) $(use_with cluster ndbcluster)"
		myconf="${myconf} $(use_with big-tables)"
	else
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --without-${i}"
		done
		myconf="${myconf} --without-berkeley-db"
		myconf="${myconf} --with-extra-charsets=none"
	fi

	# documentation
	myconf="${myconf} `use_with doc docs`"

	if useq extraengine; then
		# http://dev.mysql.com/doc/mysql/en/archive-storage-engine.html
		myconf="${myconf} --with-archive-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/csv-storage-engine.html
		myconf="${myconf} --with-csv-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/federated-description.html
		# http://dev.mysql.com/doc/mysql/en/federated-limitations.html
		#if  version_is_at_least "5.1.3" ; then
		#	einfo "before to use federated engine be sure to read"
		#	einfo "http://dev.mysql.com/doc/mysql/en/federated-limitations.html"
		#	myconf="${myconf} --with-federated-storage-engine"
		#fi
		myconf="${myconf} --with-blackhole-storage-engine"
	fi

	#glibc-2.3.2_pre fix; bug #16496
	append-flags "-DHAVE_ERRNO_AS_DEFINE=1"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	export CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti"

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
		--with-zlib-dir=/usr \
		--with-lib-ccflags="-fPIC" \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" benchdir_root="/usr/share/mysql" || die

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 /bin/false /dev/null mysql \
	|| die "problem adding user mysql"

	diropts "-m0750"
	if [[ "${PREVIOUS_DATADIR}" != "yes" ]] ; then
		dodir "${DATADIR}"
		keepdir "${DATADIR}"
		chown -R mysql:mysql "${D}/${DATADIR}"
	fi

	dodir /var/log/mysql

	diropts "-m0755"
	dodir /var/run/mysqld

	keepdir /var/run/mysqld /var/log/mysql
	chown -R mysql:mysql \
		${D}/var/run/mysqld \
		${D}/var/log/mysql

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
	if ! use perl; then
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

	if ! use utf8; then
		sed -i -e "s/utf8/latin1/" ${D}/etc/mysql/my.cnf
	fi

	# minimal builds don't have the server
	if ! useq minimal; then
		exeinto /etc/init.d
		newexe "${FILESDIR}/mysql-4.0.24-r2.rc6" mysql
		insinto /etc/logrotate.d
		newins "${FILESDIR}/logrotate.mysql" mysql
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

src_test() {
	cd ${S}
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq minimal; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI
		make test
		retstatus=$?

		# to be sure ;)
		pkill -9 -f ${S}/ndb/src/kernel/ndbd 2>/dev/null
		pkill -9 -f ${S}/ndb/src/mgmsrv/ndb_mgmd 2>/dev/null
		pkill -9 -f ${S}/ndb/src/mgmclient/ndb_mgm 2>/dev/null
		pkill -9 -f ${S}/sql/mysqld 2>/dev/null
		[[ $retstatus == 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
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

	if [[ -d "${DATADIR}/mysql" ]] ; then
		ewarn "You have already a MySQL database in place."
		ewarn "Please rename it or delete it if you wish to replace it."
		die "MySQL database already exists!"
	fi

	einfo "Creating the mysql database and setting proper"
	einfo "permissions on it..."

	einfo "Insert a password for the mysql 'root' user"
	ewarn "the password will be visible on the screen"

	echo -n "    >" && read -r pwd1
	einfo "Check the password"
	echo -n "    >" && read -r pwd2

	if ((  pwd1 != pwd2 )) ; then
		die "Passwords are not the same"
	fi

	${ROOT}/usr/bin/mysql_install_db || die "MySQL databases not installed"

	# MySQL 5.0 don't need this
	chown -R mysql:mysql ${DATADIR}
	chmod 0750 ${ROOT}/${DATADIR}

	local sqltmp="$(emktemp)"
	local help_tables="${ROOT}/usr/share/mysql/fill_help_tables.sql"
	# Filling timezones, see
	# http://dev.mysql.com/doc/mysql/en/time-zone-support.html
	${ROOT}/usr/bin/mysql_tzinfo_to_sql ${ROOT}/usr/share/zoneinfo > "${sqltmp}"

	if [[ -r "${help_tables}" ]] ; then
		cat "${help_tables}" >> "${sqltmp}"
	fi

	local socket=${ROOT}/var/run/mysqld/mysqld.sock
	local mysqld="${ROOT}/usr/sbin/mysqld \
		--skip-grant-tables \
		--basedir=${ROOT}/usr \
		--datadir=${ROOT}/var/lib/mysql \
		--skip-innodb \
		--skip-bdb \
		--skip-ndbcluster \
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

pkg_postinst() {
	mysql_get_datadir

	if ! useq minimal; then
		#empty dirs...
		[[ "${PREVIOUS_DATADIR}" != "yes" ]] \
		&& [ -d "${ROOT}/${DATADIR}" ] || install -d -m0750 -o mysql -g mysql ${ROOT}/var/lib/mysql
		[ -d "${ROOT}/var/run/mysqld" ] || install -d -m0755 -o mysql -g mysql ${ROOT}/var/run/mysqld
		[ -d "${ROOT}/var/log/mysql" ] || install -d -m0755 -o mysql -g mysql ${ROOT}/var/log/mysql

		# secure the logfiles... does this bother anybody?
		touch ${ROOT}/var/log/mysql/mysql.{log,err}
		chown mysql:mysql ${ROOT}/var/log/mysql/mysql*
		chmod 0660 ${ROOT}/var/log/mysql/mysql*
		# secure some directories
		chmod 0750 ${ROOT}/var/log/mysql ${ROOT}/${DATADIR}

		# your friendly public service announcement...
		einfo
		einfo "You might want to run:"
		einfo "\"ebuild /var/db/pkg/dev-db/${PF}/${PF}.ebuild config\""
		einfo "if this is a new install."
		einfo
		if [[ "${PREVIOUS_DATADIR}" == "yes" ]] ; then
			ewarn "Previous datadir found, it's YOUR job to change"
			ewarn "ownership and have care of it"
		fi
	fi

	mysql_upgrade_warning
	einfo "InnoDB is not optional as of MySQL-4.0.24, at the request of upstream."
}
