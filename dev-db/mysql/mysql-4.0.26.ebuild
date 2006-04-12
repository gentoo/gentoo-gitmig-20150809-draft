# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.0.26.ebuild,v 1.17 2006/04/12 04:12:06 eradicator Exp $

inherit eutils gnuconfig flag-o-matic versionator

SVER=${PV%.*}
PLV=""
NEWP="${PN}-${SVER}.$( get_version_component_range 3-3 )${PLV}"

# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="mirror://mysql/Downloads/MySQL-${SVER}/${NEWP}.tar.gz
	mirror://gentoo/mysql-extras-20050920.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="berkdb debug doc minimal perl readline selinux ssl static tcpd big-tables"
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
RDEPEND="${DEPEND}
		selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( dev-perl/DBD-mysql )"

mysql_upgrade_error() {
	ewarn "Sorry, plain up/downgrade between different version of MySQL is (still)"
	ewarn "un-supported."
}

mysql_upgrade_warning() {
	ewarn
	ewarn "If you're upgrading from MySQL-3.x to 4.0, or 4.0.x to 4.1.x, you"
	ewarn "must recompile the other packages on your system that link with"
	ewarn "libmysqlclient after the upgrade completes.  To obtain such a list"
	ewarn "of packages for your system, you may use 'revdep-rebuild' from"
	ewarn "app-portage/gentoolkit."
	ewarn
	epause 5
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
	if use static && use ssl; then
		local msg="MySQL does not support building statically with SSL support"
		eerror "${msg}"
		die "${msg}"
	fi

	unpack ${A} || die

	mv "${WORKDIR}/${NEWP}" "${S}"
	cd "${S}"

	local MY_PATCH_SOURCE="${WORKDIR}/mysql-extras"

	#zap startup script messages
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.23-install-db-sh.diff" || die
	#zap binary distribution stuff
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.18-mysqld-safe-sh.diff" || die
	#required for qmail-mysql
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0-nisam.h.diff" || die
	#for correct hardcoded sysconf directory
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0-my-print-defaults.diff" || die
	# NPTL support
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.18-gentoo-nptl.diff" || die

	# attempt to get libmysqlclient_r linked against ssl if USE="ssl" enabled
	# i would really prefer to fix this at the Makefile.am level, but can't
	# get the software to autoreconf as distributed - too many missing files
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.21-thrssl.patch" || die

	# PIC fixes
	# bug #42968
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.25-r2-asm-pic-fixes.patch" || die

	if use tcpd; then
		epatch "${MY_PATCH_SOURCE}/${PN}-4.0.14-r1-tcpd-vars-fix.diff" || die
	fi

	for d in ${S} ${S}/innobase; do
		cd ${d}
		# WARNING, plain autoconf breaks it!
		#autoconf
		# must use this instead
		WANT_AUTOCONF=2.59 autoreconf --force
		# Fix the evil "libtool.m4 and ltmain.sh have a version mismatch!"
		libtoolize --copy --force
		# Saving this for a rainy day, in case we need it again
		#WANT_AUTOMAKE=1.7 automake
		gnuconfig_update
	done

	# upstream bug http://bugs.mysql.com/bug.php?id=7971
	# names conflict with stuff in 2.6.10 kernel headers
	echo ${S}/client/mysqltest.c ${S}/extra/replace.c | xargs -n1 \
	sed -i \
		-e "s/\<set_bit\>/my__set_bit/g" \
		-e "s/\<clear_bit\>/my__clear_bit/g" \
		|| die "Failed to fix bitops"
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

	myconf="${myconf} `use_with debug` `use_with big-tables`"

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

		# lots of chars
		myconf="${myconf} --with-extra-charsets=all"

		#The following fix is due to a bug with berkdb on sparc's. See:
		#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
		# it boils down to non-64 bit safety.
		if useq sparc || useq alpha || useq hppa || useq mips || useq amd64
		then
			myconf="${myconf} --without-berkeley-db"
		else
			use berkdb \
				&& myconf="${myconf} --with-berkeley-db=./bdb" \
				|| myconf="${myconf} --without-berkeley-db"
		fi

	else
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --without-${i}"
		done
		myconf="${myconf} --without-berkeley-db"
		myconf="${myconf} --with-extra-charsets=none"
	fi

	# documentation
	myconf="${myconf} `use_with doc docs`"

	# glibc-2.3.2_pre fix; bug #16496
	append-flags "-DHAVE_ERRNO_AS_DEFINE=1"

	#bug fix for #15099, should make this api backward compatible
	append-flags "-DUSE_OLD_FUNCTIONS"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	export CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti"

	econf \
		-C \
		--libexecdir=/usr/sbin \
		--sysconfdir=/etc/mysql \
		--localstatedir=/var/lib/mysql \
		--with-low-memory \
		--enable-assembler \
		--with-charset=latin1 \
		--enable-local-infile \
		--with-mysqld-user=mysql \
		--with-client-ldflags=-lstdc++ \
		--enable-thread-safe-client \
		--with-comment="Gentoo Linux ${PF}" \
		--with-unix-socket-path=/var/run/mysqld/mysqld.sock \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_test() {
	cd ${S}
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq minimal; then
		local retstatus
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
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
	newins ${FILESDIR}/my.cnf-4.0.24-r1 my.cnf

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

		#diropts "-m0755"
		#dodir "/var/log/mysql"
		#touch ${D}/var/log/mysql/mysql.{log,err}
		#chmod 0660 ${D}/var/log/mysql/mysql.{log,err}
		#keepdir "/var/log/mysql"
		#chown -R mysql:mysql "${D}/var/log/mysql"

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
	ewarn "bug: avoid [\"'\\_%] characters in the password"

	read -rsp "    >" pwd1 ; echo
	einfo "Check the password"
	read -rsp "    >" pwd2 ; echo

	if [[  "x$pwd1" != "x$pwd2" ]] ; then
		die "Passwords are not the same"
	fi

	${ROOT}/usr/bin/mysql_install_db || die "MySQL databases not installed"

	# MySQL 5.0 don't ned this
	chown -R mysql:mysql ${ROOT}/${DATADIR}
	chmod 0750 ${ROOT}/${DATADIR}

	# now we can set the password
	local socket=${ROOT}/var/run/mysqld/mysqld.sock
	local mysqld="${ROOT}/usr/sbin/mysqld \
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
		--socket=${socket} \
		-hlocalhost \
		-e "${sql}"
	local retstatus=$?

	kill $( cat ${ROOT}/var/run/mysqld/mysqld.pid )

	[[ $retstatus == 0 ]] || die "Failed to communicate with MySQL server"

	einfo "done"
}

