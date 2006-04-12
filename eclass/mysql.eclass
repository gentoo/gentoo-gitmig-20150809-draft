# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mysql.eclass,v 1.29 2006/04/12 21:15:17 chtekk Exp $
# $ID: $

# Author: Francesco Riosa <vivo at gentoo.org>
# Maintainer: Luca Longinotti <chtekk at gentoo.org>

# MYSQL_VERSION_ID will be
# major * 10e6 + minor * 10e4 + micro * 10e2 + gentoo magic number, all [0..99]
# this is an important piece, becouse from this variable depends many of the
# choices the ebuild will do.
# in particular the code below work only with PVR like "5.0.18-r3"
# the result with the previous PVR is "5001803"
if [[ -z ${MYSQL_VERSION_ID} ]] ; then
	tpv=( ${PV//[-._]/ } ) ; tpv[3]="${PVR:${#PV}}" ; tpv[3]="${tpv[3]##*-r}"
	for vatom in 0 1 2 3; do
		# pad to lenght 2
		tpv[${vatom}]="00${tpv[${vatom}]}"
		MYSQL_VERSION_ID="${MYSQL_VERSION_ID}${tpv[${vatom}]:0-2}"
	done
	# strip leading "0" (otherwise it's considered an octal number from bash)
	MYSQL_VERSION_ID=${MYSQL_VERSION_ID##"0"}
fi

[[ -z ${MY_EXTRAS_VER} ]] && MY_EXTRAS_VER="20060411"

DEPEND="${DEPEND}
	>=sys-libs/readline-4.1
	berkdb? ( sys-apps/ed )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	userland_GNU? ( sys-process/procps )
	>=sys-libs/zlib-1.2.3
	>=sys-apps/texinfo-4.7-r1
	>=sys-apps/sed-4"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )"

inherit eutils flag-o-matic gnuconfig autotools mysql_fx

SLOT=0

# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
NEWP="${P/_/-}"
SRC_URI="mirror://mysql/Downloads/MySQL-${PV%.*}/${NEWP}.tar.gz
	mirror://gentoo/mysql-extras-${MY_EXTRAS_VER}.tar.bz2"
LICENSE="GPL-2"
IUSE="big-tables berkdb debug embedded minimal perl selinux srvdir ssl static"
RESTRICT="primaryuri confcache"

mysql_version_is_at_least "4.01.03.00" \
&& IUSE="${IUSE} cluster extraengine"

mysql_version_is_at_least "5.00.00.00" \
|| IUSE="${IUSE} raid"

mysql_version_is_at_least "5.00.18.00" \
&& IUSE="${IUSE} max-idx-128"

mysql_version_is_at_least "5.01.00.00" \
&& IUSE="${IUSE} innodb"

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_preinst \
                 pkg_postinst pkg_config pkg_postrm

# void mysql_init_vars()
#
# initialize global variables
# 2005-11-19 <vivo at gentoo.org>
mysql_init_vars() {

	MY_SHAREDSTATEDIR=${MY_SHAREDSTATEDIR:-"/usr/share/mysql"}
	MY_SYSCONFDIR=${MY_SYSCONFDIR="/etc/mysql"}
	MY_LIBDIR=${MY_LIBDIR="/usr/$(get_libdir)/mysql"}
	MY_LOCALSTATEDIR=${MY_LOCALSTATEDIR="/var/lib/mysql"}
	MY_LOGDIR=${MY_LOGDIR="/var/log/mysql"}
	MY_INCLUDEDIR=${MY_INCLUDEDIR="/usr/include/mysql"}

	if [ -z "${DATADIR}" ]; then
		DATADIR=""
		if [ -f "${MY_SYSCONFDIR}/my.cnf" ] ; then
			DATADIR=`"my_print_defaults" mysqld 2>/dev/null \
				| sed -ne '/datadir/s|^--datadir=||p' \
				| tail -n1`
			if [ -z "${DATADIR}" ]; then
				if useq "srvdir" ; then
					DATADIR="${ROOT}/srv/localhost/mysql/datadir"
				else
					DATADIR=`grep ^datadir "${MY_SYSCONFDIR}/my.cnf" \
						| sed -e 's/.*=\s*//'`
				fi
			fi
		fi
		if [ -z "${DATADIR}" ]; then
			if useq "srvdir" ; then
				DATADIR="${ROOT}/srv/localhost/mysql/datadir"
			else
				DATADIR="${MY_LOCALSTATEDIR}"
			fi
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

	export MY_SHAREDSTATEDIR MY_SYSCONFDIR
	export MY_LIBDIR MY_LOCALSTATEDIR MY_LOGDIR
	export MY_INCLUDEDIR
	export DATADIR
}

mysql_pkg_setup() {

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

mysql_src_unpack() {

	mysql_init_vars

	if useq "static" && useq "ssl" ; then
		local msg="MySQL does not support building statically with SSL support"
		eerror "${msg}"
		die "${msg}"
	fi

	if mysql_version_is_at_least "4.01.03.00" \
	&& useq "cluster" \
	|| useq "extraengine" \
	&& useq "minimal" ; then
		die "USEs cluster, extraengine conflicts with \"minimal\""
	fi

	unpack ${A} || die

	mv -f "${WORKDIR}/${NEWP}" "${S}"
	cd "${S}"

	EPATCH_SUFFIX="patch"
	mkdir -p "${EPATCH_SOURCE}" || die "unable to create epatch directory"
	mysql_mv_patches
	epatch || die "failed to apply all patches"

	# additional check, remove bundled zlib
	rm -f "${S}/zlib/"*.[ch]
	sed -i -e "s/zlib\/Makefile dnl/dnl zlib\/Makefile/" "${S}/configure.in"
	rm -f scripts/mysqlbug

	# Make charsets install in the right place
	find . -name 'Makefile.am' \
		-exec sed --in-place -e 's!$(pkgdatadir)!'${MY_SHAREDSTATEDIR}'!g' {} \;

	# Manage mysqlmanager
	mysql_version_is_at_least "5.00.15.00" \
	&& sed -i -e "s!@GENTOO_EXT@!!g" \
		-e "s!@GENTOO_SOCK_PATH@!var/run/mysqld!g" \
		"${S}/server-tools/instance-manager/Makefile.am"

	# remove what need to be recreated, so we are sure it's actually done
	find . -name Makefile \
		-o -name Makefile.in \
		-o -name configure \
		-exec rm -f {} \;
	rm ltmain.sh

	local rebuilddirlist d buildstep bdbdir

	if mysql_version_is_at_least "5.01.00.00" ; then
		rebuilddirlist=". storage/innobase"
		bdbdir='storage/bdb/dist'
	else
		rebuilddirlist=". innobase"
		bdbdir='bdb/dist'
	fi

	for d in ${rebuilddirlist}; do
		einfo "reconfiguring dir \"${d}\""
		pushd "${d}" &>/dev/null
		AT_GNUCONF_UPDATE="yes" eautoreconf
		popd &>/dev/null
	done

	#TODO berkdb in 5.1 need to be worked on
	if useq "berkdb" && ! mysql_check_version_range "5.01.00.00 to 5.01.08.99"
	then
		[[ -w "${bdbdir}/ltmain.sh" ]] && cp -f ltmain.sh "${bdbdir}/ltmain.sh"
		pushd "${bdbdir}" \
			&& sh s_all \
			|| die "failed bdb reconfigure" \
			&>/dev/null
		popd &>/dev/null
	fi

}

mysql_src_compile() {

	mysql_init_vars
	local myconf

	if useq "static" ; then
		myconf="${myconf} --with-mysqld-ldflags=-all-static"
		myconf="${myconf} --with-client-ldflags=-all-static"
		myconf="${myconf} --disable-shared"
	else
		myconf="${myconf} --enable-shared --enable-static"
	fi

	#myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} --without-libwrap"

	if useq "ssl" ; then
		# --with-vio is not needed anymore, it's on by default and
		# has been removed from configure
		mysql_version_is_at_least "5.00.04.00" || myconf="${myconf} --with-vio"
		if mysql_version_is_at_least "5.00.06.00" ; then
			# yassl-0.96 is young break with gcc-4.0 || amd64
			#myconf="${myconf} --with-yassl"
			myconf="${myconf} --with-openssl"
		else
			myconf="${myconf} --with-openssl"
		fi
	else
		myconf="${myconf} --without-openssl"
	fi

	if useq "debug"; then
		myconf="${myconf} --with-debug=full"
	else
		myconf="${myconf} --without-debug"
		mysql_version_is_at_least "4.01.03.00" \
		&& useq "cluster" \
		&& myconf="${myconf} --without-ndb-debug"
	fi

	# these are things we exclude from a minimal build
	# note that the server actually does get built and installed
	# but we then delete it before packaging.
	local minimal_exclude_list="server embedded-server extra-tools innodb bench"

	if ! useq "minimal" ; then
		myconf="${myconf} --with-server"
		myconf="${myconf} --with-extra-tools"

		if useq "static" ; then
			myconf="${myconf} --without-raid"
			ewarn "disabling raid support, has problem with static"
		else
			if mysql_version_is_at_least "5.00.00.00" ; then
				myconf="${myconf} --without-raid"
			else
				myconf="${myconf} `use_with raid`"
			fi
		fi

		if mysql_version_is_at_least "4.01.00.00" ; then
			myconf="${myconf} --with-charset=utf8"
			myconf="${myconf} --with-collation=utf8_general_ci"
		else
			myconf="${myconf} --with-charset=latin1"
			myconf="${myconf} --with-collation=latin1_swedish_ci"
		fi

		# optional again from 2005-12-05
		if mysql_version_is_at_least "5.01.00.00" ; then
			myconf="${myconf} $(use_with innodb)"
		else
			myconf="${myconf} --with-innodb"
		fi

		# lots of chars
		myconf="${myconf} --with-extra-charsets=all"

		#The following fix is due to a bug with bdb on sparc's. See:
		#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
		# it comes down to non-64-bit safety problems
		if useq "sparc" || useq "alpha" || useq "hppa" || useq "mips" \
		|| useq "amd64" || mysql_check_version_range "5.01.00.00 to 5.01.06.99"
		then
			ewarn "bdb berkeley-db disabled due to arch or version"
			myconf="${myconf} --without-berkeley-db"
		else
			#TODO berkdb in 5.1 need to be worked on
			useq "berkdb" && \
			! mysql_check_version_range "5.01.00.00 to 5.01.08.99" \
				&& myconf="${myconf} --with-berkeley-db=./bdb" \
				|| myconf="${myconf} --without-berkeley-db"
		fi

		if mysql_version_is_at_least "4.01.03.00" ; then
			#myconf="${myconf} $(use_with geometry)"
			myconf="${myconf} --with-geometry"
			myconf="${myconf} $(use_with cluster ndbcluster)"
		fi

		mysql_version_is_at_least "4.01.11.00" \
		&&  myconf="${myconf} `use_with big-tables`"

		mysql_version_is_at_least "5.01.06.00" \
		&&  myconf="${myconf} --with-ndb-binlog"

		if useq "embedded" ; then
			#REMIND, need the privilege control enabled ?
			myconf="${myconf} --without-embedded-privilege-control"
			myconf="${myconf} --with-embedded-server"
		else
			myconf="${myconf} --without-embedded-privilege-control"
			myconf="${myconf} --without-embedded-server"
		fi

		# benchmarking stuff needs perl
		if useq "perl" ; then
			myconf="${myconf} --with-bench"
		else
			myconf="${myconf} --without-bench"
		fi
	else
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --without-${i}"
		done
		myconf="${myconf} --without-berkeley-db"
		myconf="${myconf} --with-extra-charsets=none"
	fi

	if mysql_version_is_at_least "4.01.03.00" && useq "extraengine"; then
		# http://dev.mysql.com/doc/mysql/en/archive-storage-engine.html
		myconf="${myconf} --with-archive-storage-engine"
		# http://dev.mysql.com/doc/mysql/en/csv-storage-engine.html

		mysql_version_is_at_least "4.01.04.00" \
		&& myconf="${myconf} --with-csv-storage-engine"

		mysql_version_is_at_least "4.01.11.00" \
		&&  myconf="${myconf} --with-blackhole-storage-engine"

		# http://dev.mysql.com/doc/mysql/en/federated-description.html
		# http://dev.mysql.com/doc/mysql/en/federated-limitations.html
		if mysql_version_is_at_least "5.00.03.00" ; then
			einfo "before to use federated engine be sure to read"
			einfo "http://dev.mysql.com/doc/refman/5.0/en/federated-limitations.html"
			myconf="${myconf} --with-federated-storage-engine"

			# http://dev.mysql.com/doc/refman/5.1/en/partitioning-overview.html
			if mysql_version_is_at_least "5.01.00.00" ; then
				myconf="${myconf} --with-partition"
			fi
		fi

	fi

	mysql_version_is_at_least "5.00.18.00" \
	&& useq "max-idx-128" \
	&& myconf="${myconf} --with-max-indexes=128"

	if mysql_version_is_at_least "5.01.05.00" ; then
		myconf="${myconf} --with-row-based-replication"
	fi

	#TODO rechek again later, had problem with assembler enabled
	#     and some combination of use-flags with 5.1
	if mysql_check_version_range "5.01.00.00 to 5.01.08.99" ; then
		myconf="${myconf} --disable-assembler"
	else
		myconf="${myconf} --enable-assembler"
	fi

	#Bug #114895,Bug #110149
	filter-flags "-O" "-O[01]"
	#glibc-2.3.2_pre fix; bug #16496
	append-flags "-DHAVE_ERRNO_AS_DEFINE=1"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	export CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti"
	mysql_version_is_at_least "5.00.00.00" \
	&& export CXXFLAGS="${CXXFLAGS} -fno-implicit-templates"

	econf \
		--libexecdir="/usr/sbin" \
		--sysconfdir="${MY_SYSCONFDIR}" \
		--localstatedir="${MY_LOCALSTATEDIR}" \
		--sharedstatedir="${MY_SHAREDSTATEDIR}" \
		--libdir="${MY_LIBDIR}" \
		--includedir="${MY_INCLUDEDIR}" \
		--with-low-memory \
		--enable-local-infile \
		--with-mysqld-user=mysql \
		--with-client-ldflags=-lstdc++ \
		--enable-thread-safe-client \
		--with-comment="Gentoo Linux ${PF}" \
		--with-unix-socket-path="/var/run/mysqld/mysqld.sock" \
		--without-readline \
		--without-docs \
		${myconf} || die "bad ./configure"

	# TODO Move this before autoreconf !!!
	find . -type f -name Makefile -print0 \
	| xargs -0 -n100 sed -i \
	-e 's|^pkglibdir *= *$(libdir)/mysql|pkglibdir = $(libdir)|;s|^pkgincludedir *= *$(includedir)/mysql|pkgincludedir = $(includedir)|'

	emake || die "compile problem"
}

mysql_src_install() {

	mysql_init_vars
	make install DESTDIR="${D}" benchdir_root="${MY_SHAREDSTATEDIR}" || die

	insinto "${MY_INCLUDEDIR}"
	doins "${MY_INCLUDEDIR}"/my_{config,dir}.h

	# convenience links
	dosym "/usr/bin/mysqlcheck" "/usr/bin/mysqlanalyze"
	dosym "/usr/bin/mysqlcheck" "/usr/bin/mysqlrepair"
	dosym "/usr/bin/mysqlcheck" "/usr/bin/mysqloptimize"

	# various junk (my-*.cnf moved elsewhere)
	rm -rf "${D}/usr/share/info"
	for removeme in  "mysql-log-rotate" mysql.server* \
		binary-configure* my-*.cnf mi_test_all*
	do
		rm -f ${D}/usr/share/mysql/${removeme}
	done

	# clean up stuff for a minimal build
	# this is anything server-specific
	if useq "minimal" ; then
		rm -rf ${D}${MY_SHAREDSTATEDIR}/{mysql-test,sql-bench}
		rm -f ${D}/usr/bin/{mysql{_install_db,manager*,_secure_installation,_fix_privilege_tables,hotcopy,_convert_table_format,d_multi,_fix_extensions,_zap,_explain_log,_tableinfo,d_safe,_install,_waitpid,binlog,test},myisam*,isam*,pack_isam}
		rm -f "${D}/usr/sbin/mysqld"
		rm -f ${D}${MY_LIBDIR}/lib{heap,merge,nisam,my{sys,strings,sqld,isammrg,isam},vio,dbug}.a
	fi

	# config stuff
	insinto "${MY_SYSCONFDIR}"
	doins scripts/mysqlaccess.conf
	sed -e "s!@MY_SUFFIX@!!g" \
		-e "s!@DATADIR@!${DATADIR}!g" \
		"${FILESDIR}/my.cnf-4.1-r1" \
		> "${TMPDIR}/my.cnf.ok"
	newins "${TMPDIR}/my.cnf.ok" my.cnf

	insinto "/etc/conf.d"
	newins "${FILESDIR}/mysql.conf.d-r1" "mysql"
	mysql_version_is_at_least "5.00.11.00" \
	&& newins "${FILESDIR}/mysqlmanager.conf.d" "mysqlmanager"

	# minimal builds don't have the server
	if ! useq "minimal" ; then
		exeinto /etc/init.d
		newexe "${FILESDIR}/mysql.rc6-r3" "mysql"

		mysql_version_is_at_least "5.00.11.00" \
		&& newexe "${FILESDIR}/mysqlmanager.rc6" "mysqlmanager"
		insinto /etc/logrotate.d
		newins "${FILESDIR}/logrotate.mysql" "mysql"

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
			chown -R mysql:mysql "${D}/${folder}"
		done
	fi

	# docs
	dodoc README COPYING ChangeLog EXCEPTIONS-CLIENT INSTALL-SOURCE
	# minimal builds don't have the server
	if ! useq "minimal" ; then
		docinto "support-files"
		for script in \
			support-files/my-*.cnf \
			support-files/magic \
			support-files/ndb-config-2-node.ini
		do
			dodoc "${script}"
		done

		docinto "scripts"
		for script in scripts/mysql* ; do
			[[ "${script%.sh}" == "${script}" ]] && dodoc "${script}"
		done
	fi

	ROOT="${D}" mysql_lib_symlinks
}

mysql_pkg_preinst() {

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

mysql_pkg_postinst() {

	mysql_init_vars

	# mind at FEATURES=collision-protect before to remove this
	[ -d "${ROOT}/var/log/mysql" ] \
		|| install -d -m0750 -o mysql -g mysql "${ROOT}${MY_LOGDIR}"

	#secure the logfiles... does this bother anybody?
	touch "${ROOT}${MY_LOGDIR}"/mysql.{log,err}
	chown mysql:mysql "${ROOT}${MY_LOGDIR}"/mysql*
	chmod 0660 "${ROOT}${MY_LOGDIR}"/mysql*

	if ! useq "minimal" ; then
		# your friendly public service announcement...
		einfo
		einfo "You might want to run:"
		einfo "\"emerge --config =${CATEGORY}/${PF}\""
		einfo "if this is a new install."
		einfo
		mysql_version_is_at_least "5.01.00.00" \
		|| einfo "InnoDB is not optional as of MySQL-4.0.24, at the request of upstream."
	fi
}

mysql_pkg_config() {
	mysql_init_vars
	[[ -z "${DATADIR}" ]] && die "sorry, unable to find DATADIR"

	if built_with_use dev-db/mysql minimal; then
		die "Minimal builds do NOT include the MySQL server"
	fi

	local pwd1="a"
	local pwd2="b"
	local maxtry=5

	if [[ -d "${ROOT}/${DATADIR}/mysql" ]] ; then
		ewarn "You have already a MySQL database in place."
		ewarn "(${ROOT}/${DATADIR}/*)"
		ewarn "Please rename or delete it if you wish to replace it."
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

	local options=""
	local sqltmp="$(emktemp)"

	local help_tables="${MY_SHAREDSTATEDIR}/fill_help_tables.sql"
	[[ -r "${help_tables}" ]] \
	&& cp "${help_tables}" "${TMPDIR}/fill_help_tables.sql" \
	|| touch "${TMPDIR}/fill_help_tables.sql"
	help_tables="${TMPDIR}/fill_help_tables.sql"

	pushd "${TMPDIR}" &>/dev/null
	${ROOT}/usr/bin/mysql_install_db | grep -B5 -A999 -i "ERROR"
	popd &>/dev/null
	[[ -f ${ROOT}/${DATADIR}/mysql/user.frm ]] \
	|| die "MySQL databases not installed"
	chown -R mysql:mysql ${ROOT}/${DATADIR} 2> /dev/null
	chmod 0750 ${ROOT}/${DATADIR} 2> /dev/null

	if mysql_version_is_at_least "4.01.03.00" ; then
		options="--skip-ndbcluster"

		# Filling timezones, see
		# http://dev.mysql.com/doc/mysql/en/time-zone-support.html
		${ROOT}/usr/bin/mysql_tzinfo_to_sql ${ROOT}/usr/share/zoneinfo \
		> "${sqltmp}" 2>/dev/null

		if [[ -r "${help_tables}" ]] ; then
			cat "${help_tables}" >> "${sqltmp}"
		fi
	fi

	local socket=${ROOT}/var/run/mysqld/mysqld${RANDOM}.sock
	local pidfile=${ROOT}/var/run/mysqld/mysqld${RANDOM}.pid
	local mysqld="${ROOT}/usr/sbin/mysqld \
		${options} \
		--user=mysql \
		--skip-grant-tables \
		--basedir=${ROOT}/usr \
		--datadir=${ROOT}/${DATADIR} \
		--skip-innodb \
		--skip-bdb \
		--skip-networking \
		--max_allowed_packet=8M \
		--net_buffer_length=16K \
		--socket=${socket} \
		--pid-file=${pidfile}"
	$mysqld &
	while ! [[ -S "${socket}" || "${maxtry}" -lt 1 ]] ; do
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

	einfo "Loading \"zoneinfo\" this step may require few seconds"

	${ROOT}/usr/bin/mysql \
		--socket=${socket} \
		-hlocalhost \
		-uroot \
		-p"${pwd1}" \
		mysql < "${sqltmp}"

	# server stop and cleanup
	kill $(< "${pidfile}" )
	rm  "${sqltmp}"
	einfo "stopping the server,"
	wait %1
	einfo "done"
}

mysql_pkg_postrm() {
	mysql_lib_symlinks
}
