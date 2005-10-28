# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-5.0.15-r30.ebuild,v 1.1 2005/10/28 15:42:56 vivo Exp $

MYSQL_VERSION_ID=50015
PROTOCOL_VERSION=10
NDB_VERSION_ID=50015
SLOT="${MYSQL_VERSION_ID}"

inherit eutils flag-o-matic versionator

SVER=${PV%.*}
NEWP="${PN}-${PV}"
NEWP="${NEWP/_beta/-beta}"
NEWP="${NEWP/_rc/-rc}"

# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="mirror://mysql/Downloads/MySQL-${SVER}/${NEWP}.tar.gz
	mirror://gentoo/mysql-extras-20050920.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="-*"
IUSE="big-tables berkdb debug minimal perl selinux ssl static"
RESTRICT="primaryuri"

DEPEND=">=sys-libs/readline-4.1
	bdb? ( sys-apps/ed )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	userland_GNU? ( sys-process/procps )
	>=sys-libs/zlib-1.2.3
	>=sys-apps/texinfo-4.7-r1
	>=sys-apps/sed-4"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )"

mysql_version_is_at_least() {

	local want_s="$1" have_s="${2:-${MYSQL_VERSION_ID}}"
	[[ -z "${want_s}" ]] && die "mysql_version_is_at_least missing value"

	[[ ${want_s} -le ${have_s} ]] \
	&& return 0 \
	|| return 1
}

if mysql_version_is_at_least 40103 ; then
	# 2005-09-29
	#   geometry has been removed due to repeated compile problems _without_ it.
	#   From now on it will be always enabled
	IUSE="${IUSE} cluster utf8 extraengine"
fi

mysql_upgrade_error() {
	: # TODO
}

mysql_init_vars() {

	MY_SUFFIX=${MY_SUFFIX:-"-${SLOT}"}
	MY_SHAREDSTATEDIR=${MY_SHAREDSTATEDIR:-"/usr/share/mysql${MY_SUFFIX}"}
	MY_SYSCONFDIR=${MY_SYSCONFDIR="/etc/mysql${MY_SUFFIX}"}
	MY_LIBDIR=${MY_LIBDIR="/usr/$(get_libdir)/mysql${MY_SUFFIX}"}
	MY_LOCALSTATEDIR=${MY_LOCALSTATEDIR="/var/lib/mysql${MY_SUFFIX}"}
	MY_LOGDIR=${MY_LOGDIR="/var/log/mysql${MY_SUFFIX}"}
	MY_INCLUDEDIR=${MY_INCLUDEDIR="/usr/include/mysql${MY_SUFFIX}"}

	# source configure.in for this one
	AVAILABLE_LANGUAGES="\
czech danish dutch english estonian french german greek hungarian \
italian japanese japanese-sjis korean norwegian norwegian-ny polish portuguese \
romanian russian serbian slovak spanish swedish ukrainian"

	if [ -z "${DATADIR}" ]; then
		DATADIR=""
		if [ -f "${SYSCONFDIR}/my.cnf" ] ; then
			DATADIR=`"my_print_defaults${MY_SUFFIX}" mysqld 2>/dev/null | sed -ne '/datadir/s|^--datadir=||p' | tail -n1`
			if [ -z "${DATADIR}" ]; then
				DATADIR=`grep ^datadir "${SYSCONFDIR}/my.cnf" | sed -e 's/.*=\s*//'`
			fi
		fi
		if [ -z "${DATADIR}" ]; then
			DATADIR="${MY_LOCALSTATEDIR}"
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
	fi

	export MY_SUFFIX MY_SHAREDSTATEDIR MY_SYSCONFDIR
	export MY_LIBDIR MY_LOCALSTATEDIR MY_LOGDIR
	export MY_INCLUDEDIR
	export DATADIR AVAILABLE_LANGUAGES
}

pkg_setup() {

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

	if mysql_version_is_at_least 40103 \
	&& useq cluster \
	|| useq extraengine \
	&& useq minimal ; then
		die "USEs cluster, extraengine conflicts with \"minimal\""
	fi

	unpack ${A} || die

	mv "${WORKDIR}/${NEWP}" "${S}"
	cd "${S}"
	rm -rf "${S}/zlib/"*.[ch]
	sed -i -e "s/zlib\/Makefile dnl/dnl zlib\/Makefile/" "${S}/configure.in"

	local MY_PATCH_SOURCE="${WORKDIR}/mysql-extras"

	# TODO ensure we are using system libraries

	epatch "${MY_PATCH_SOURCE}/010_all_my-print-defaults-r2.patch" || die
	epatch "${MY_PATCH_SOURCE}/035_x86_asm-pic-fixes-r7.patch" || die
	epatch "${MY_PATCH_SOURCE}/703_all_test-rpl_rotate_logs.patch" || die
	#epatch "${MY_PATCH_SOURCE}/705_all_view_geometry.patch" || die

	find . -name Makefile -o -name Makefile.in -o -name configure -exec rm {} \;
	aclocal && autoheader \
		|| die "failed reconfigure step 01"
	libtoolize --automake --force \
		|| die "failed reconfigure step 02"
	automake --force --add-missing && autoconf \
		|| die "failed reconfigure step 03"

	if mysql_version_is_at_least 50100 ; then
		pushd storage/innobase || die "failed chdir"
	else
		pushd innobase || die "failed chroot"
	fi
	aclocal && autoheader && autoconf && automake
	popd

	pushd bdb/dist && sh s_all \
		|| die "failed bdb reconfigure"
	popd

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

	mysql_init_vars
	local myconf

	if useq static ; then
		myconf="${myconf} --with-mysqld-ldflags=-all-static"
		myconf="${myconf} --with-client-ldflags=-all-static"
		myconf="${myconf} --disable-shared"
	else
		myconf="${myconf} --enable-shared --enable-static"
	fi

	#myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} --without-libwrap"

	if useq ssl ; then
		# --with-vio is not needed anymore, it's on by default and
		# has been removed from configure
		mysql_version_is_at_least 50004 || myconf="${myconf} --with-vio"
		if mysql_version_is_at_least 50006 ; then
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
		mysql_version_is_at_least 40103 && useq cluster && myconf="${myconf} --without-ndb-debug"
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

		if ! mysql_version_is_at_least 50000 ; then
			if mysql_version_is_at_least 40100 && useq utf8; then
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

		if mysql_version_is_at_least 40103 ; then
			#myconf="${myconf} $(use_with geometry)"
			myconf="${myconf} --with-geometry"
			myconf="${myconf} $(use_with cluster ndbcluster)"
		fi

		mysql_version_is_at_least 40111 &&  myconf="${myconf} --with-big-tables"
	else
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --without-${i}"
		done
		myconf="${myconf} --without-berkeley-db"
		myconf="${myconf} --with-extra-charsets=none"
	fi

	if mysql_version_is_at_least 40103 && useq extraengine; then
		# http://dev.mysql.com/doc/mysql/en/archive-storage-engine.html
		myconf="${myconf} --with-archive-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/csv-storage-engine.html
		mysql_version_is_at_least 40104 \
		&& myconf="${myconf} --with-csv-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/federated-description.html
		# http://dev.mysql.com/doc/mysql/en/federated-limitations.html
		if mysql_version_is_at_least 50003 ; then
			einfo "before to use federated engine be sure to read"
			einfo "http://dev.mysql.com/doc/mysql/en/federated-limitations.html"
			myconf="${myconf} --with-federated-storage-engine"
		fi
		mysql_version_is_at_least 40111 \
		&&  myconf="${myconf} --with-blackhole-storage-engine"
	fi

	myconf="${myconf} `use_with big-tables`"

	#glibc-2.3.2_pre fix; bug #16496
	append-flags "-DHAVE_ERRNO_AS_DEFINE=1"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	export CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti"
	mysql_version_is_at_least 50000 \
	&& export CXXFLAGS="${CXXFLAGS} -fno-implicit-templates"

	econf \
		--program-suffix="${MY_SUFFIX}" \
		--libexecdir="/usr/sbin" \
		--sysconfdir="${MY_SYSCONFDIR}" \
		--localstatedir="${MY_LOCALSTATEDIR}" \
		--sharedstatedir="${MY_SHAREDSTATEDIR}" \
		--libdir="${MY_LIBDIR}" \
		--includedir="${MY_INCLUDEDIR}" \
		--with-low-memory \
		--enable-assembler \
		--enable-local-infile \
		--with-mysqld-user=mysql \
		--with-client-ldflags=-lstdc++ \
		--enable-thread-safe-client \
		--with-comment="Gentoo Linux ${PF}" \
		--with-unix-socket-path="/var/run/mysqld/mysqld${MY_SUFFIX}.sock" \
		--with-zlib-dir=/usr \
		--with-lib-ccflags="-fPIC" \
		--program-suffix="${MY_SUFFIX}" \
		--without-readline \
		--without-docs \
		${myconf} || die "bad ./configure"

	# TODO Move this before autoreconf !!!
	find . -name 'Makefile' \
	-exec sed --in-place \
	-e 's|^pkglibdir\s*=\s*$(libdir)/mysql|pkglibdir = $(libdir)|' \
	-e 's|^pkgincludedir\s*=\s*$(includedir)/mysql|pkgincludedir = $(includedir)|' \
	{} \;

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

		mysql_version_is_at_least 50015 \
		&& make test-force-pl \
		|| make test-pl
		retstatus=$?

		# to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}

src_install() {

	mysql_init_vars
	make install DESTDIR="${D}" benchdir_root="${MY_SHAREDSTATEDIR}" || die

	# TODO : is this a work for eselect ?
	# move client libs, install a couple of missing headers
	dosym \
		"${MY_LIBDIR}/libmysqlclient.so" \
		"${MY_LIBDIR}/../libmysqlclient.so"
	dosym \
		"${MY_LIBDIR}/libmysqlclient_r.so" \
		"${MY_LIBDIR}/../libmysqlclient_r.so"

	insinto "${MY_INCLUDEDIR}"
	doins "${MY_INCLUDEDIR}"/my_{config,dir}.h

	# convenience links
	dosym "/usr/bin/mysqlcheck${MY_SUFFIX}" "/usr/bin/mysqlanalyze${MY_SUFFIX}"
	dosym "/usr/bin/mysqlcheck${MY_SUFFIX}" "/usr/bin/mysqlrepair${MY_SUFFIX}"
	dosym "/usr/bin/mysqlcheck${MY_SUFFIX}" "/usr/bin/mysqloptimize${MY_SUFFIX}"

	rm -rf "${D}/usr/share/info"

	# various junk
	rm -f "${D}/usr/share/mysql"/mysql-log-rotate
	rm -f "${D}/usr/share/mysql"/mysql.server*
	rm -f "${D}/usr/share/mysql"/binary-configure*
	rm -f "${D}/usr/share/mysql"/my-*.cnf # Put them elsewhere
	rm -f "${D}/usr/share/mysql"/mi_test_all*
	rm -f "${D}/usr/share/mysql"/mysql_fix_privilege_tables.sql
	rm -f "${D}/usr/share/mysql"/fill_help_tables.sql
	rm -f "${D}/usr/share/mysql"/ndb-config-2-node.ini

	# mmh buggy install code || buggy ebuild (always true)?
	# this should be in ${MY_SHAREDSTATEDIR}
	for moveme in charsets $AVAILABLE_LANGUAGES	errmsg.txt ; do
		mv "${D}/usr/share/mysql/${moveme}" "${D}${MY_SHAREDSTATEDIR}/"
	done

	local notcatched=$(ls "${D}/usr/share/mysql"/*)
	if [[ -n "${notcatched}" ]] ; then
		ewarn "QA notice"
		ewarn "${notcatched} files in /usr/share/mysql"
		ewarn "bug mysql-herd to manage them"
	fi
	rm -rf "${D}/usr/share/mysql"

	# clean up stuff for a minimal build
	# this is anything server-specific
	if useq minimal; then
		rm -rf ${D}${MY_SHAREDSTATEDIR}/{mysql-test,sql-bench}
		rm -f ${D}/usr/bin/{mysql{_install_db,manager*,_secure_installation,_fix_privilege_tables,hotcopy,_convert_table_format,d_multi,_fix_extensions,_zap,_explain_log,_tableinfo,d_safe,_install,_waitpid,binlog,test},myisam*,isam*,pack_isam}
		rm -f "${D}/usr/sbin/mysqld${MY_SUFFIX}"
		rm -f ${D}${MY_LIBDIR}/lib{heap,merge,nisam,my{sys,strings,sqld,isammrg,isam},vio,dbug}.a
	fi

	# TODO
	# config stuff
	insinto "${MY_SYSCONFDIR}"
	doins scripts/mysqlaccess.conf
	newins "${FILESDIR}/my.cnf-4.1" my.cnf

	if mysql_version_is_at_least 40103 && ! useq utf8; then
		sed --in-place -e "s/utf8/latin1/" \
			"${D}/etc/mysql${MY_SUFFIX}/my.cnf"
	fi

	# minimal builds don't have the server
	if ! useq minimal; then
		exeinto /etc/init.d
		# TODO
		newexe "${FILESDIR}/mysql-4.0.24-r2.rc6" "mysql"
		insinto /etc/logrotate.d
		# TODO
		newins "${FILESDIR}/logrotate.mysql" "mysql${MY_SUFFIX}"

		#empty dirs...
		diropts "-m0750"
		if [[ "${PREVIOUS_DATADIR}" != "yes" ]] ; then
			dodir "${DATADIR}"
			keepdir "${DATADIR}"
			chown -R mysql:mysql "${D}/${DATADIR}"
		fi

		diropts "-m0755"
		for folder in "${MY_LOGDIR}" "/var/run/mysqld" ; do
			dodir "${folder}"
			keepdir "${folder}"
			chown -R mysql:mysql "${folder}"
		done
	fi

	# docs
	dodoc README COPYING ChangeLog EXCEPTIONS-CLIENT INSTALL-SOURCE
	# minimal builds don't have the server
	if ! useq minimal; then
		docinto "support-files"
		for script in \
			support-files/my-*.cnf \
			support-files/magic \
			support-files/ndb-config-2-node.ini
		do
			dodoc "${script}"
		done

		docinto "scripts"
		for script in \
			$(ls scripts/mysql* | grep -v '.sh$') \
			scripts/*.sql
		do
			dodoc "${script}"
		done
	fi
}

pkg_preinst() {

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

pkg_postinst() {

	mysql_init_vars
	# mind at FEATURES=collision-protect before to remove this
	[ -d "${ROOT}/var/log/mysql" ] \
		|| install -d -m0750 -o mysql -g mysql "${ROOT}${MY_LOGDIR}"

	#secure the logfiles... does this bother anybody?
	touch "${ROOT}${MY_LOGDIR}"/mysql.{log,err}
	chown mysql:mysql "${ROOT}${MY_LOGDIR}"/mysql*
	chmod 0660 "${ROOT}${MY_LOGDIR}"/mysql*

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
	: # TODO
}
