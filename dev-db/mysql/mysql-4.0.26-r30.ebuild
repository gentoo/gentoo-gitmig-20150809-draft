# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.0.26-r30.ebuild,v 1.1 2005/10/28 15:42:56 vivo Exp $

MYSQL_VERSION_ID=40026
PROTOCOL_VERSION=8
NDB_VERSION_ID=0
SLOT="${MYSQL_VERSION_ID}"

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
KEYWORDS="-*"
IUSE="berkdb debug minimal perl selinux ssl static tcpd big-tables"
RESTRICT="primaryuri"

DEPEND=">=sys-libs/readline-4.1
		bdb? ( sys-apps/ed )
		tcpd? ( >=sys-apps/tcp-wrappers-7.6-r6 )
		ssl? ( >=dev-libs/openssl-0.9.6d )
		userland_GNU? ( sys-process/procps )
		>=sys-libs/zlib-1.2.3
		>=sys-apps/texinfo-4.7-r1
		>=sys-apps/sed-4"
RDEPEND="${DEPEND}
		selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( dev-perl/DBD-mysql )"

mysql_version_is_at_least() {

	local want_s="$1" have_s="${2:-${MYSQL_VERSION_ID}}"
	[[ -z "${want_s}" ]] && die "mysql_version_is_at_least missing value"

	[[ ${want_s} -le ${have_s} ]] \
	&& return 0 \
	|| return 1
}

mysql_upgrade_warning() {
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
italian japanese korean norwegian norwegian-ny polish portuguese \
romanian russian slovak spanish swedish ukrainian"

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

	unpack ${A} || die

	mv "${WORKDIR}/${NEWP}" "${S}"
	cd "${S}"

	# TODO ensure we are using system libraries

	local MY_PATCH_SOURCE="${WORKDIR}/mysql-extras"

	#zap startup script messages
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.23-install-db-sh.diff" || die
	#zap binary distribution stuff
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.18-mysqld-safe-sh.diff" || die
	# isam index lenght
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0-nisam.h.diff" || die
	# hardcoded sysconf directory, managed by slotting code
	#epatch "${MY_PATCH_SOURCE}/${PN}-4.0-my-print-defaults.diff" || die
	# NPTL support
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.18-gentoo-nptl.diff" || die

	# attempt to get libmysqlclient_r linked against ssl if USE="ssl" enabled
	# i would really prefer to fix this at the Makefile.am level, but can't
	# get the software to autoreconf as distributed - too many missing files
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.21-thrssl.patch" || die

	# PIC fixes
	# bug #42968
	epatch "${MY_PATCH_SOURCE}/${PN}-4.0.25-r2-asm-pic-fixes.patch" || die

	if useq tcpd; then
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
}

src_compile() {
	mysql_init_vars
	local myconf

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

		# lots of chars
		myconf="${myconf} --with-extra-charsets=all"

		#The following fix is due to a bug with bdb on sparc's. See:
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

	# glibc-2.3.2_pre fix; bug #16496
	append-flags "-DHAVE_ERRNO_AS_DEFINE=1"

	#bug fix for #15099, should make this api backward compatible
	append-flags "-DUSE_OLD_FUNCTIONS"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	export CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti"

	econf \
		-C \
		--program-suffix="${MY_SUFFIX}" \
		--libexecdir="/usr/sbin" \
		--sysconfdir="${MY_SYSCONFDIR}" \
		--localstatedir="${MY_LOCALSTATEDIR}" \
		--sharedstatedir="${MY_SHAREDSTATEDIR}" \
		--libdir="${MY_LIBDIR}" \
		--includedir="${MY_INCLUDEDIR}" \
		--with-low-memory \
		--enable-assembler \
		--with-charset=latin1 \
		--enable-local-infile \
		--with-mysqld-user=mysql \
		--with-client-ldflags=-lstdc++ \
		--enable-thread-safe-client \
		--with-comment="Gentoo Linux ${PF}" \
		--with-unix-socket-path="/var/run/mysqld/mysqld${MY_SUFFIX}.sock" \
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
		local retstatus
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		addpredict /this-dir-does-not-exist/t9.MYI
		make test
		retstatus=$?

		# to be sure ;)
		pkill -9 -f ${S}/ndb/ 2>/dev/null
		pkill -9 -f ${S}/sql/ 2>/dev/null
		[[ $retstatus == 0 ]] || die "make test failed"

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

	# mmh buggy install code || buggy ebuild (always true)?
	# this should be in ${MY_SHAREDSTATEDIR}
	for moveme in charsets $AVAILABLE_LANGUAGES	; do
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
	newins "${FILESDIR}/my.cnf-4.0.24-r1" my.cnf

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

	# need empty datadir
	echo "1) chroot the server";

	# need empty datadir
	echo "2) install system tables";

	# need system tables + prev. db running
	echo "3) copy previous database";

	# create a bunch of symlinks, bin, sbin, man, share, etc
	echo "4) make default install (client binaries and library)"

	# need external tools
	echo "5) rebuild dependancies"

	# TODO chroot
	# /chroot/mysql${MY_SUFFIX}
	# etc/mysql
	# tmp
	# /var/tmp/../log/../run/

	# cp /usr/local/libexec/mysqld /chroot/mysql/usr/local/libexec/
	# cp -Rv /usr/local/share/mysql /chroot/mysql/usr/local/share/
	# cp /etc/hosts /chroot/mysql/etc/
	# cp /etc/resolv.conf /chroot/mysql/etc/
	# cp /etc/group /chroot/mysql/etc/
	# cp /etc/master.passwd /chroot/mysql/etc/passwords
	# cp /etc/my.cnf /chroot/mysql/etc/

	# /chroot/mysql/etc/passwords and /chroot/mysql/etc/group
	# Remove every entry except for the sys and mysql group
	# root and mysql.  Then change the root shell to /sbin/nologin

	# mknod /chroot/mysql/dev/null c 2 2
	# chown root:sys /chroot/mysql/dev/null
	# chmod 666 /chroot/mysql/dev/null
	# mknod null c 2 2
	# mknod random c 2 3
	# mknod urandom c 2 4
	# mknod zero c 2 12

	# /chroot/mysql/var/lib/mysql-cluster/config.ini

	# install -C /usr/bin/cat /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/date /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/hostname /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/ls /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/rm /chroot/mysql-40026/usr/bin
	# install -C /bin/bash /chroot/mysql-40026/usr/bin
	# install -C /bin/sh /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/nohup /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/sed /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/tee /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/touch /chroot/mysql-40026/usr/bin
	# install -C /usr/bin/chown /chroot/mysql/usr/sbin/
	# install /usr/bin/true /chroot/mysql-40026/usr/bin
	# install /usr/bin/expr /chroot/mysql-40026/usr/bin
	# install /bin/kill /chroot/mysql-40026/usr/bin
	# install /usr/bin/sed /chroot/mysql-40026/usr/bin
	# install /bin/ps /chroot/mysql-40026/usr/bin
	# install /bin/grep /chroot/mysql-40026/usr/bin
	# install /usr/bin/tee /chroot/mysql-40026/usr/bin
	# install /usr/bin/touch /chroot/mysql-40026/usr/bin
	# install /bin/bash /chroot/mysql-40026/usr/bin
	# install /bin/sh /chroot/mysql-40026/usr/bin
	# install /usr/bin/echo /chroot/mysql-40026/usr/bin

	# cp /usr/local/bin/my* /chroot/mysql/usr/local/bin/
	# cp /usr/local/bin/safe_mysqld /chroot/mysql/usr/local/bin/

	# chown -R root:sys /chroot/mysql
	# chmod -R 755 /chroot/mysql
	# chmod 1777 /chroot/mysql/tmp
	# chown -R mysql:mysql /chroot/mysql/var/db/mysql

#cp ld-*.so*
#find . -type f -exec ldd {} 2>/dev/null \; \
#|grep '=> /' \
#|awk '{ print $3}' \
#|sort \
#|uniq

#|awk -F"=>" {'print $2'}| awk -F" " {'print $1'} | grep -v '^(')


#for i in $pippo ; do dirname $i >> etc/ld.so.conf.tmp ; done
#sort etc/ld.so.conf.tmp | uniq > etc/ld.so.conf && rm etc/ld.so.conf.tmp
#for i in $(cat etc/ld.so.conf) ; do mkdir -p ".${i}" ; done
#for i in $pippo ; do cp $i /chroot/mysql-40026/$i ; done

# env -i ldconfig -r /chroot/mysql-40026/
#check: 	ldconfig -p -r /chroot/mysql-40026/
#/etc/ld.so.conf


}
