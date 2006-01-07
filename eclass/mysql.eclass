# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mysql.eclass,v 1.4 2006/01/07 16:43:39 vivo Exp $

# Author: Francesco Riosa <vivo at gentoo.org>
# Maintainer: Francesco Riosa <vivo at gentoo.org>

inherit eutils flag-o-matic gnuconfig mysql_fx

#major, minor only in the slot
SLOT=$(( ${MYSQL_VERSION_ID} / 10000 ))

# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
NEWP="${PN}-${PV/_/-}"
SRC_URI="mirror://mysql/Downloads/MySQL-${PV%.*}/${NEWP}.tar.gz
	mirror://gentoo/mysql-extras-20051220.tar.bz2"
LICENSE="GPL-2"
IUSE="big-tables berkdb debug minimal perl selinux ssl static"
RESTRICT="primaryuri"
DEPEND="app-admin/eselect-mysql"

mysql_version_is_at_least "4.01.03.00" \
&& IUSE="${IUSE} cluster utf8 extraengine"

mysql_version_is_at_least "5.00.18.00" \
&& IUSE="${IUSE} max-idx-128"

mysql_version_is_at_least "5.01.00.00" \
&& IUSE="${IUSE} innodb"

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_preinst pkg_postinst pkg_config pkg_postrm

mysql_pkg_setup() {

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

mysql_src_unpack() {

	mysql_init_vars

	if useq static && useq ssl; then
		local msg="MySQL does not support building statically with SSL support"
		eerror "${msg}"
		die "${msg}"
	fi

	if mysql_version_is_at_least "4.01.03.00" \
	&& useq cluster \
	|| useq extraengine \
	&& useq minimal ; then
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

	# Multilib issue with zlib detection
	mysql_version_is_at_least "5.00.15.00" \
	&& sed -i -e "s:zlib_dir/lib:zlib_dir/$(get_libdir):g" \
		"${S}/config/ac-macros/zlib.m4"

	# Make charsets install in the right place
	find . -name 'Makefile.am' \
		-exec sed --in-place -e 's!$(pkgdatadir)!'${MY_SHAREDSTATEDIR}'!g' {} \;

	# Manage mysqlmanager
	mysql_version_is_at_least "5.00.15.00" \
	&& sed -i -e "s!@GENTOO_EXT@!${MY_SUFFIX}!g" \
		-e "s!@GENTOO_SOCK_PATH@!var/run/mysqld!g" \
		"${S}/server-tools/instance-manager/Makefile.am"

	# remove what need to be recreated, so we are sure it's actually done
	find . -name Makefile -o -name Makefile.in -o -name configure -exec rm -f {} \;
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
		for buildstep in \
			'libtoolize --copy --force' \
			'aclocal --force' \
			'autoheader --force -Wnone' \
			'autoconf --force -Wnone' \
			'automake --force --force-missing -Wnone' \
			'gnuconfig_update'
		do
			einfo "performing ${buildstep}"
			${buildstep} || die "failed ${buildstep/ */} dir \"${d}\""
		done
		popd &>/dev/null
	done

	if ! mysql_check_version_range "5.01.00.00 to 5.01.06.99" ; then
		[[ -w "${bdbdir}/ltmain.sh" ]] && cp -f ltmain.sh "${bdbdir}/ltmain.sh"
		pushd "${bdbdir}" && sh s_all || die "failed bdb reconfigure" &>/dev/null
		popd &>/dev/null
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

	if useq debug; then
		myconf="${myconf} --with-debug=full"
	else
		myconf="${myconf} --without-debug"
		mysql_version_is_at_least "4.01.03.00" && useq cluster && myconf="${myconf} --without-ndb-debug"
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

		if ! mysql_version_is_at_least "5.00.00.00" ; then
			if mysql_version_is_at_least "4.01.00.00" && useq utf8; then
				myconf="${myconf} --with-charset=utf8"
				myconf="${myconf} --with-collation=utf8_general_ci"
			else
				myconf="${myconf} --with-charset=latin1"
				myconf="${myconf} --with-collation=latin1_swedish_ci"
			fi
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
		if useq sparc || useq alpha || useq hppa || useq mips || useq amd64 \
		|| mysql_check_version_range "5.01.00.00 to 5.01.06.99"
		then
			ewarn "bdb berkeley-db disabled due to arch or version"
			myconf="${myconf} --without-berkeley-db"
		else
			useq berkdb \
				&& myconf="${myconf} --with-berkeley-db=./bdb" \
				|| myconf="${myconf} --without-berkeley-db"
		fi

		if mysql_version_is_at_least "4.01.03.00" ; then
			#myconf="${myconf} $(use_with geometry)"
			myconf="${myconf} --with-geometry"
			myconf="${myconf} $(use_with cluster ndbcluster)"
		fi

		mysql_version_is_at_least "4.01.11.00" &&  myconf="${myconf} `use_with big-tables`"
	else
		for i in ${minimal_exclude_list}; do
			myconf="${myconf} --without-${i}"
		done
		myconf="${myconf} --without-berkeley-db"
		myconf="${myconf} --with-extra-charsets=none"
	fi

	if mysql_version_is_at_least "4.01.03.00" && useq extraengine; then
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

		mysql_version_is_at_least "5.00.18.00" \
		&& useq "max-idx-128" \
		&& myconf="${myconf} --with-max-indexes=128"
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

mysql_src_install() {

	mysql_init_vars
	make install DESTDIR="${D}" benchdir_root="${MY_SHAREDSTATEDIR}" || die

	insinto "${MY_INCLUDEDIR}"
	doins "${MY_INCLUDEDIR}"/my_{config,dir}.h

	# convenience links
	dosym "/usr/bin/mysqlcheck${MY_SUFFIX}" "/usr/bin/mysqlanalyze${MY_SUFFIX}"
	dosym "/usr/bin/mysqlcheck${MY_SUFFIX}" "/usr/bin/mysqlrepair${MY_SUFFIX}"
	dosym "/usr/bin/mysqlcheck${MY_SUFFIX}" "/usr/bin/mysqloptimize${MY_SUFFIX}"

	# various junk (my-*.cnf moved elsewhere)
	rm -rf "${D}/usr/share/info"
	for removeme in  "mysql-log-rotate" mysql.server* \
		binary-configure* my-*.cnf mi_test_all*
	do
		rm -f ${D}/usr/share/mysql/${removeme}
	done

	# TODO change at Makefile-am level
	for moveme in "mysql_fix_privilege_tables.sql" \
		"fill_help_tables.sql" "ndb-config-2-node.ini"
	do
		mv -f "${D}/usr/share/mysql/${moveme}" "${D}/usr/share/mysql${MY_SUFFIX}/" 2>/dev/null
	done

	if [[ -n "${MY_SUFFIX}" ]] ; then
		local notcatched=$(ls "${D}/usr/share/mysql"/*)
		if [[ -n "${notcatched}" ]] ; then
			ewarn "QA notice"
			ewarn "${notcatched} files in /usr/share/mysql"
			ewarn "bug mysql-herd to manage them"
		fi
		rm -rf "${D}/usr/share/mysql"
	fi

	# clean up stuff for a minimal build
	# this is anything server-specific
	if useq minimal; then
		rm -rf ${D}${MY_SHAREDSTATEDIR}/{mysql-test,sql-bench}
		rm -f ${D}/usr/bin/{mysql{_install_db,manager*,_secure_installation,_fix_privilege_tables,hotcopy,_convert_table_format,d_multi,_fix_extensions,_zap,_explain_log,_tableinfo,d_safe,_install,_waitpid,binlog,test},myisam*,isam*,pack_isam}
		rm -f "${D}/usr/sbin/mysqld${MY_SUFFIX}"
		rm -f ${D}${MY_LIBDIR}/lib{heap,merge,nisam,my{sys,strings,sqld,isammrg,isam},vio,dbug}.a
	fi

	# config stuff
	insinto "${MY_SYSCONFDIR}"
	doins scripts/mysqlaccess.conf
	newins "${FILESDIR}/my.cnf-4.1" my.cnf
	insinto "/etc/conf.d"
	newins "${FILESDIR}/mysql-slot.conf.d-r1" "mysql"
	mysql_version_is_at_least "5.00.11.00" \
	&& newins "${FILESDIR}/mysqlmanager-slot.conf.d" "mysqlmanager"

	local charset='utf8'
	! useq utf8 && local charset='latin1'
	sed --in-place \
		-e "s/@MY_SUFFIX@/${MY_SUFFIX}/" \
		-e "s/@CHARSET@/${charset}/" \
		"${D}/etc/mysql${MY_SUFFIX}/my.cnf"

	# minimal builds don't have the server
	if ! useq minimal; then
		exeinto /etc/init.d
		newexe "${FILESDIR}/mysql-slot.rc6-r1" "mysql"
		mysql_version_is_at_least "5.00.11.00" \
		&& newexe "${FILESDIR}/mysqlmanager-slot.rc6" "mysqlmanager"
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
			chown -R mysql:mysql "${D}/${folder}"
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
		for script in scripts/mysql* ; do
			[[ "${script%.sh}" == "${script}" ]] && dodoc "${script}"
		done
	fi

	# oops, temporary fix
	mysql_check_version_range "5.00.16.00 to 5.00.18.99" \
	&& cp -f \
		"${WORKDIR}/mysql-extras/fill_help_tables.sql-5.0.15" \
		"${D}/usr/share/mysql${MY_SUFFIX}/fill_help_tables.sql"

	# create a list of executable files, to be used
	# by external utilities
	# uncompressed because of the small size
	local exelist="usr/share/mysql${MY_SUFFIX}/.exe-list"
	pushd "${D}/" &>/dev/null
		env -i find usr/bin/ usr/sbin/ usr/share/man \
			-type f -name "*${MY_SUFFIX}*" \
			> "${exelist}"
		echo "${MY_SYSCONFDIR##"/"}" >> "${exelist}"
		echo "${MY_INCLUDEDIR##"/"}" >> "${exelist}"
		echo "${MY_LIBDIR##"/"}" >> "${exelist}"
		echo "${MY_SHAREDSTATEDIR##"/"}" >> "${exelist}"
	popd &>/dev/null
}

mysql_pkg_preinst() {

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

mysql_pkg_postinst() {

	mysql_init_vars
	mysql_lib_symlinks

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
		einfo "\"emerge --config =${CATEGORY}/${PF}\""
		einfo "if this is a new install."
		einfo
	fi

	einfo "InnoDB is not optional as of MySQL-4.0.24, at the request of upstream."
	if [[ ${SLOT} -gt 0 ]] ; then
		einfo "you may want to run \"eselect myqsl list\" followed by a "
		einfo "\"eselect myqsl list\" to chose the default mysql server"
		einfo "Prior to do this unmerge any unslotted MySQL versions with "
		einfo "emerge -C -p dev-db/mysql <<< NOTICE the \"-p\""
		einfo "emerge -C =dev-db/mysql-X.Y.Z"
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

	local help_tables="${ROOT}/usr/share/doc/mysql-${PVR}/scripts/fill_help_tables.sql.gz"
	[[ -r "${help_tables}" ]] \
	&& zcat "${help_tables}" > "${TMPDIR}/fill_help_tables.sql" \
	|| touch "${TMPDIR}/fill_help_tables.sql"
	help_tables="${TMPDIR}/fill_help_tables.sql"

	pushd "${TMPDIR}" &>/dev/null
	${ROOT}/usr/bin/mysql_install_db${MY_SUFFIX} | grep -B5 -A999 -i "ERROR"
	popd &>/dev/null
	[[ -f ${ROOT}/${DATADIR}/mysql/user.frm ]] 	|| die "MySQL databases not installed"
	chown -R mysql:mysql ${ROOT}/${DATADIR} 2> /dev/null
	chmod 0750 ${ROOT}/${DATADIR} 2> /dev/null

	if mysql_version_is_at_least "4.01.03.00" ; then
		options="--skip-ndbcluster"

		# Filling timezones, see
		# http://dev.mysql.com/doc/mysql/en/time-zone-support.html
		${ROOT}/usr/bin/mysql_tzinfo_to_sql${MY_SUFFIX} ${ROOT}/usr/share/zoneinfo \
		> "${sqltmp}" 2>/dev/null

		if [[ -r "${help_tables}" ]] ; then
			cat "${help_tables}" >> "${sqltmp}"
		fi
	fi

	local socket=${ROOT}/var/run/mysqld/mysqld${MY_SUFFIX}${RANDOM}.sock
	local pidfile=${ROOT}/var/run/mysqld/mysqld${MY_SUFFIX}${RANDOM}.sock
	local mysqld="${ROOT}/usr/sbin/mysqld${MY_SUFFIX} \
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
	${ROOT}/usr/bin/mysql${MY_SUFFIX} \
		--socket=${socket} \
		-hlocalhost \
		-e "${sql}"

	einfo "Loading \"zoneinfo\" this step may require few seconds"

	${ROOT}/usr/bin/mysql${MY_SUFFIX} \
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
	if [[ ${SLOT} -gt 0 ]] ; then
		einfo "you may want to run \"eselect myqsl list\" followed by a "
		einfo "\"eselect myqsl list\" to chose the default mysql server"
	fi
}
