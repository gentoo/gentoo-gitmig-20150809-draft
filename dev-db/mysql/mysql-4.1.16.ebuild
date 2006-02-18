# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.16.ebuild,v 1.8 2006/02/18 11:35:44 vivo Exp $

# helper function, version (integer) may have section separated by dots
# for readbility
stripdots() {
	local dotver=${1:-"0"}
	while [[ "${dotver/./}" != "${dotver}" ]] ; do dotver="${dotver/./}" ; done
	echo "${dotver:-"0"}"
}

# major * 10e6 + minor * 10e4 + micro * 10e2 + gentoo magic number, all [0..99]
MYSQL_VERSION_ID=$(stripdots "4.01.16.00")
NDB_VERSION_ID=40116
#major, minor only in the slot
SLOT=0
#NOSLOT SLOT=$(( ${MYSQL_VERSION_ID} / 10000 ))

inherit eutils flag-o-matic gnuconfig

# shorten the path because the socket path length must be shorter than 107 chars
# and we will run a mysql server during test phase
S="${WORKDIR}/${PN}"

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
NEWP="${PN}-${PV/_/-}"
SRC_URI="mirror://mysql/Downloads/MySQL-${PV%.*}/${NEWP}.tar.gz
	mirror://gentoo/mysql-extras-20051220.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="big-tables berkdb debug minimal perl selinux ssl static"
RESTRICT="primaryuri"

DEPEND=">=sys-libs/readline-4.1
	berkdb? ( sys-apps/ed )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	userland_GNU? ( sys-process/procps )
	>=sys-libs/zlib-1.2.3
	>=sys-apps/texinfo-4.7-r1
	>=sys-apps/sed-4"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )"

# Is $2 (defaults to $MYSQL_VERSION_ID) at least version $1?
# (nice) idea from versionator.eclass
mysql_version_is_at_least() {
	local want_s=$(stripdots "$1") have_s=$( stripdots "${2:-${MYSQL_VERSION_ID}}")
	[[ -z "${want_s}" ]] && die "mysql_version_is_at_least missing value"
	[[ ${want_s} -le ${have_s} ]] && return 0 || return 1
}

mysql_version_is_at_least "4.01.03.00" \
&& IUSE="${IUSE} cluster utf8 extraengine"

mysql_version_is_at_least "5.00.18.00" \
&& IUSE="${IUSE} max-idx-128"

mysql_version_is_at_least "5.01.00.00" \
&& IUSE="${IUSE} innodb"

# bool mysql_check_version_range(char * range, int ver=MYSQL_VERSION_ID, int die_on_err=MYSQL_DIE_ON_RANGE_ERROR)
#
# Check if a version number fall inside a range.
# the range include the extremes and must be specified as
# "low_version to hi_version" i.e. "4.00.00.00 to 5.01.99.99"
# Return true if inside the range
# 2005-11-19 <vivo at gentoo.org>
mysql_check_version_range() {
	local lbound="${1%% to *}" ; lbound=$(stripdots "${lbound}")
	local rbound="${1#* to }"  ; rbound=$(stripdots "${rbound}")
	local my_ver="${2:-"${MYSQL_VERSION_ID}"}"
	[[ $lbound -le $my_ver && $my_ver -le $rbound ]] && return 0
	return 1
}

# private bool _mysql_test_patch_easy( int flags, char * pname )
#
# true if found at least one appliable range
# 2005-11-19 <vivo at gentoo.org>
_mysql_test_patch_easy() {
	local filesdir="${WORKDIR}/mysql-extras"
	[[ -d "${filesdir}" ]] || die 'sourcedir must be a directory'
	local flags=$1 pname=$2
	if [[ $(( $flags & 5 )) -eq 5 ]] ; then
		einfo "using \"${pname}\""
		mv "${filesdir}/${pname}" "${EPATCH_SOURCE}" || die "cannot move ${pname}"
		return 0
	fi
	return 1
}

# void mysql_mv_patches(char * index_file, char * filesdir, int my_ver)
#
# parse a "index_file" looking for patches to apply to current
# version.
# If the patch apply then print it's description
# 2005-11-19 <vivo at gentoo.org>
mysql_mv_patches() {
	local index_file="${1:-"${WORKDIR}/mysql-extras/index.txt"}"
	local my_ver="${2:-"${MYSQL_VERSION_ID}"}"
	local my_test_fx=${3:-"_mysql_test_patch_easy"}
	local dsc=(), ndsc=0 i

	# values for flags are (2^x):
	#  1 - one patch found
	#  2 - at  least one version range is wrong
	#  4 - at  least one version range is _good_
	local flags=0 pname='' comments=''
	while read row; do
		case "${row}" in
			@patch\ *)
				${my_test_fx} $flags "${pname}" \
				&& for (( i=0 ; $i < $ndsc ; i++ )) ; do einfo ">    ${dsc[$i]}" ; done
				flags=1 ; ndsc=0 ; dsc=()
				pname=${row#"@patch "}
				;;
			@ver\ *)
				if mysql_check_version_range "${row#"@ver "}" "${my_ver}" ; then
					flags=$(( $flags | 4 ))
				else
					flags=$(( $flags | 2 ))
				fi
				;;
			# @use\ *) ;;
			@@\ *)
				dsc[$ndsc]="${row#"@@ "}"
				(( ++ndsc ))
				;;
		esac
	done < "${index_file}"
	${my_test_fx} $flags "${pname}" \
		&& for (( i=0 ; $i < $ndsc ; i++ )) ; do einfo ">    ${dsc[$i]}" ; done
}


# void mysql_init_vars()
#
# initialize global variables
# 2005-11-19 <vivo at gentoo.org>
mysql_init_vars() {

	MY_SUFFIX=""
	#NOSLOT MY_SUFFIX=${MY_SUFFIX:-"-${SLOT}"}
	MY_SHAREDSTATEDIR=${MY_SHAREDSTATEDIR:-"/usr/share/mysql${MY_SUFFIX}"}
	MY_SYSCONFDIR=${MY_SYSCONFDIR="/etc/mysql${MY_SUFFIX}"}
	MY_LIBDIR=${MY_LIBDIR="/usr/$(get_libdir)/mysql${MY_SUFFIX}"}
	MY_LOCALSTATEDIR=${MY_LOCALSTATEDIR="/var/lib/mysql${MY_SUFFIX}"}
	MY_LOGDIR=${MY_LOGDIR="/var/log/mysql${MY_SUFFIX}"}
	MY_INCLUDEDIR=${MY_INCLUDEDIR="/usr/include/mysql${MY_SUFFIX}"}

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
	export DATADIR
}

mysql_strip_double_slash() {
	local path="${1}"
	local newpath="${path/\/\///}"
	while [[ ${path} != ${newpath} ]]; do
		path=${newpath}
		newpath="${path/\/\///}"
	done
	echo "${newpath}"
}

pkg_setup() {

	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 -1 /dev/null mysql \
	|| die "problem adding user mysql"
}

src_unpack() {

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

	mv "${WORKDIR}/${NEWP}" "${S}"
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
		pushd "${d}"
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
		popd
	done

	if ! mysql_check_version_range "5.01.00.00 to 5.01.06.99" ; then
		[[ -w "${bdbdir}/ltmain.sh" ]] && cp ltmain.sh "${bdbdir}/ltmain.sh"
		pushd "${bdbdir}" && sh s_all || die "failed bdb reconfigure"
		popd
	fi

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

		#The following fix is due to a bug with berkdb on sparc's. See:
		#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
		# it comes down to non-64-bit safety problems
		if useq sparc || useq alpha || useq hppa || useq mips || useq amd64 \
		|| mysql_check_version_range "5.01.00.00 to 5.01.06.99"
		then
			ewarn "berkdb berkeley-db disabled due to arch or version"
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

src_test() {
	cd ${S}
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq minimal; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI

		mysql_version_is_at_least "5.00.15.00" \
		&& make test-force-pl \
		|| make test
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

	# create globally visible symlinks
	# TODO : what abaut ndb ?
	local mylib mylibfullver mylibtmpver maxdots sonamelist
	pushd "${D}/${MY_LIBDIR}"
	for mylib in libmysqlclient_r libmysqlclient libndbclient; do
		mylibfullver="$(ls "${mylib}.so"* | sort | tail -n 1)"
		mylibtmpver="${mylibfullver}"
		maxdots=0
		while [[ ${mylibtmpver} != ${mylib} ]] && [[ ${maxdots} -lt 6 ]]; do
			(( ++maxdots ))
			dosym \
				$(mysql_strip_double_slash "${MY_LIBDIR}/${mylibfullver}") \
				$(mysql_strip_double_slash "${MY_LIBDIR}/../${mylibtmpver}")
			mylibtmpver=${mylibtmpver%.*}
		done
	done
	popd

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
		rm -f "${D}/usr/share/mysql/${removeme}"
	done

	# oops
	mysql_check_version_range "5.00.16.00 to 5.00.18.99" \
	&& cp "${WORKDIR}/mysql-extras/fill_help_tables.sql-5.0.15" "${D}/usr/share/mysql/"

	# TODO change at Makefile-am level
	for moveme in "mysql_fix_privilege_tables.sql" \
		"fill_help_tables.sql" "ndb-config-2-node.ini"
	do
		mv "${D}/usr/share/mysql/${moveme}"/ "${D}/usr/share/mysql${MY_SUFFIX}/" 2>/dev/null
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
		for script in \
			$(ls scripts/mysql* | grep -v '.sh$')
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

	## TODO : make the check
	## TODO : what abaut ndb ?
	#local mylib mylibfullver mylibtmpver maxdots sonamelist prevlink
	#pushd "${ROOT}/${MY_LIBDIR}"
	#for mylib in libmysqlclient_r libmysqlclient libndbclient; do
	#	mylibfullver="$(ls "${mylib}.so"* | sort | tail -n 1)"
	#	mylibtmpver="${mylibfullver}"
	#	maxdots=0
	#	while [[ ${mylibtmpver} != ${mylib} ]] && [[ ${maxdots} -lt 6 ]]; do
	#		(( ++maxdots ))
	#		prevlink=$(readlink -f "../${mylibtmpver}")
	#		if [[ -n "${prevlink}" ]] ; then
	#			if [[ "${mylibtmpver}" != "${mylibfullver}" ]] \
	#			&& [[ "${prevlink##*/}" != "${mylibfullver}" ]]
	#			then
	#				# gah this is not totally correct
	#				einfo "found previous library, please run"
	#				einfo "revdep-rebuild --soname=${mylibtmpver}"
	#			fi
	#			rm -f "../${mylibtmpver}"
	#		fi
	#		ln -snf \
	#			$(mysql_strip_double_slash "${ROOT}/${MY_LIBDIR}/${mylibfullver}") \
	#			$(mysql_strip_double_slash "${ROOT}/${MY_LIBDIR}/../${mylibtmpver}")
	#		mylibtmpver=${mylibtmpver%.*}
	#	done
	#done
	#popd

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
}

pkg_config() {
	mysql_init_vars
	[[ -z "${DATADIR}" ]] && die "sorry, unable to find DATADIR"

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

	pushd "${TMPDIR}"
	${ROOT}/usr/bin/mysql_install_db${MY_SUFFIX} | grep -B5 -A999 -i "ERROR"
	popd
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
