# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php4_4-sapi.eclass,v 1.13 2006/03/12 13:24:36 chtekk Exp $
#
# ########################################################################
#
# eclass/php4_4-sapi.eclass
#               Eclass for building different php4 SAPI instances
#
#				USE THIS ECLASS FOR THE "CONCENTRATED" PACKAGES
#
#               Based on robbat2's work on the php4 sapi eclass
#
# Author(s)		Stuart Herbert
#				<stuart@gentoo.org>
#
#				Luca Longinotti
#				<chtekk@gentoo.org>
#
# ========================================================================

CONFUTILS_MISSING_DEPS="adabas birdstep db2 dbmaker empress empress-bcs esoob frontbase hyperwave-api informix interbase mnogosearch msql oci8 oracle7 ovrimos pfpro sapdb solid sybase sybase-ct"
EBUILD_SUPPORTS_SHAREDEXT=1

inherit flag-o-matic eutils confutils libtool php-common-r1

# set MY_PHP_P in the ebuild

# we only set these variables if we're building a copy of php which can be
# installed as a package in its own right
#
# copies of php which are compiled into other packages (e.g. php support
# for the thttpd web server) don't need these variables

if [[ "${PHP_PACKAGE}" == 1 ]] ; then
	HOMEPAGE="http://www.php.net/"
	LICENSE="PHP-3"
	SRC_URI="http://www.php.net/distributions/${MY_PHP_P}.tar.bz2"
	S="${WORKDIR}/${MY_PHP_P}"
fi

IUSE="${IUSE} adabas bcmath berkdb birdstep bzip2 calendar cdb cjk crypt ctype curl db2 dba dbase dbmaker dbx debug doc empress empress-bcs esoob exif expat fastbuild frontbase fdftk filepro firebird flatfile ftp gd gd-external gdbm gmp hardenedphp hyperwave-api iconv imap informix inifile interbase iodbc ipv6 java-internal java-external kerberos ldap libedit mcal mcve memlimit mhash ming mnogosearch msql mssql mysql ncurses nls oci8 oci8-instant-client odbc oracle7 overload ovrimos pcntl pcre pfpro pic posix postgres readline recode sapdb session sharedext sharedmem snmp sockets solid spell sqlite ssl sybase sybase-ct sysvipc threads tiff tokenizer truetype wddx xml xmlrpc xpm xsl yaz zip zlib"

# these USE flags should have the correct dependencies
DEPEND="${DEPEND}
	!dev-php/php
	!dev-php/php-cgi
	!dev-php/mod_php
	berkdb? ( =sys-libs/db-4* )
	bzip2? ( app-arch/bzip2 )
	cdb? ( dev-db/cdb )
	crypt? ( >=dev-libs/libmcrypt-2.4 )
	curl? ( >=net-misc/curl-7.10.5 )
	fdftk? ( app-text/fdftk )
	firebird? ( dev-db/firebird )
	gd? ( >=media-libs/jpeg-6b media-libs/libpng )
	gd-external? ( media-libs/gd )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	gmp? ( dev-libs/gmp )
	imap? ( virtual/imap-c-client )
	iodbc? ( dev-db/libiodbc )
	java-internal? ( =virtual/jdk-1.4* dev-java/java-config !dev-php4/php-java-bridge )
	kerberos? ( virtual/krb5 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	libedit? ( dev-libs/libedit )
	mcal? ( dev-libs/libmcal !=dev-libs/libmcal-0.7-r2 )
	mcve? ( net-libs/libmonetra )
	mhash? ( app-crypt/mhash )
	ming? ( media-libs/ming )
	mssql? ( dev-db/freetds )
	mysql? ( dev-db/mysql )
	ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	oci8-instant-client? ( dev-db/oracle-instantclient-basic )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	postgres? ( >=dev-db/libpq-7.1 )
	readline? ( sys-libs/readline )
	recode? ( app-text/recode )
	sharedmem? ( dev-libs/mm )
	snmp? ( >=net-analyzer/net-snmp-5.2 )
	spell? ( >=app-text/aspell-0.50 )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	sybase? ( dev-db/freetds )
	tiff? ( media-libs/tiff )
	truetype? ( =media-libs/freetype-2* >=media-libs/t1lib-5.0.0 )
	xpm? ( || ( x11-libs/libXpm virtual/x11 ) )
	xml? ( dev-libs/libxml2 xsl? ( dev-libs/libxslt ) )
	xmlrpc? ( dev-libs/expat )
	xsl? ( app-text/sablotron dev-libs/expat )
	zlib? ( sys-libs/zlib )
	virtual/mta"

# libswf conflicts with ming and should not
# be installed with the new PHP ebuilds
DEPEND="${DEPEND} !media-libs/libswf"

# 9libs causes a configure error
DEPEND="${DEPEND} !dev-libs/9libs"

# simplistic for now
RDEPEND="${RDEPEND} ${DEPEND}"

# those are only needed at compile-time
DEPEND="${DEPEND}
		>=sys-devel/m4-1.4.3
		>=sys-devel/libtool-1.5.18
		>=sys-devel/automake-1.9.6
		sys-devel/automake-wrapper
		>=sys-devel/autoconf-2.59
		sys-devel/autoconf-wrapper"

# Additional features
#
# They are in PDEPEND because we need PHP installed first!
PDEPEND="${PDEPEND}
		doc? ( app-doc/php-docs )
		java-external? ( dev-php4/php-java-bridge )
		sqlite? ( dev-php4/pecl-sqlite )
		yaz? ( dev-php4/pecl-yaz )
		zip? ( dev-php4/pecl-zip )"

# ========================================================================
# php.ini Support
# ========================================================================

PHP_INI_FILE="php.ini"

# ========================================================================

EXPORT_FUNCTIONS pkg_setup src_compile src_install src_unpack pkg_postinst

# ========================================================================
# INTERNAL FUNCTIONS
# ========================================================================

php4_4-sapi_check_awkward_uses() {
	# ------------------------------------
	# Rules for things unexpectedly broken
	# go below here
	#
	# These rules override the "normal"
	# rules listed later on
	# ------------------------------------

	# No special rules at the moment

	# ------------------------------------
	# Normal rules go below here
	# ------------------------------------

	# A variety of extensions need DBA
	confutils_use_depend_all "berkdb"	"dba"
	confutils_use_depend_all "cdb"		"dba"
	confutils_use_depend_all "flatfile"	"dba"
	confutils_use_depend_all "gdbm"		"dba"
	confutils_use_depend_all "inifile"	"dba"

	# DBX checks
	confutils_use_depend_any "dbx" "frontbase" "mssql" "odbc" "postgres" "sybase-ct" "oci8" "oci8-instant-client"

	# DOM XML support
	confutils_use_depend_all "xml"		"zlib"

	# EXIF only gets built if we support a file format that uses it
	confutils_use_depend_any "exif" "gd" "gd-external" "tiff"

	# support for the GD graphics library
	confutils_use_conflict "gd" "gd-external"
	confutils_use_depend_any "truetype" "gd" "gd-external"
	confutils_use_depend_any "cjk"	"gd" "gd-external"
	confutils_use_depend_all "tiff"	"gd"
	confutils_use_depend_all "xpm"	"gd"
	confutils_use_depend_all "gd"	"zlib"

	# IMAP support
	php_check_imap

	# Java support
	php_check_java

	# Java-external support
	confutils_use_conflict "java-external" "java-internal"
	confutils_use_depend_all "java-external" "session"

	# Mail support
	php_check_mta

	# Oracle support
	confutils_use_conflict "oci8" "oci8-instant-client"
	php_check_oracle_all

	# MCVE needs OpenSSL
	confutils_use_depend_all "mcve" "ssl"

	# ODBC support
	confutils_use_depend_all "adabas"		"odbc"
	confutils_use_depend_all "birdstep"		"odbc"
	confutils_use_depend_all "dbmaker"		"odbc"
	confutils_use_depend_all "empress"		"odbc"
	confutils_use_depend_all "empress-bcs"	"odbc" "empress"
	confutils_use_depend_all "esoob"		"odbc"
	confutils_use_depend_all "db2"			"odbc"
	confutils_use_depend_all "iodbc"		"odbc"
	confutils_use_depend_all "sapdb"		"odbc"
	confutils_use_depend_all "solid"		"odbc"

	# Readline and libedit do the same thing; you can't have both
	confutils_use_conflict "readline" "libedit"

	# Recode is not liked
	confutils_use_conflict "recode" "mysql" "imap" "yaz"

	# the MM extension isn't thread-safe
	confutils_use_conflict "sharedmem" "threads"

	confutils_warn_about_missing_deps
}

php4_4-sapi_set_php_ini_dir() {
	PHP_INI_DIR="/etc/php/${PHPSAPI}-php4"
	PHP_EXT_INI_DIR="${PHP_INI_DIR}/ext"
	PHP_EXT_INI_DIR_ACTIVE="${PHP_INI_DIR}/ext-active"
}

php4_4-sapi_install_ini() {
	destdir=/usr/$(get_libdir)/php4

	# get the extension dir
	PHPEXTDIR="`"${D}/${destdir}/bin/php-config" --extension-dir`"

	# work out where we are installing the ini file
	php4_4-sapi_set_php_ini_dir

	local phpinisrc=php.ini-dist

	dodir ${PHP_INI_DIR}
	insinto ${PHP_INI_DIR}
	newins ${phpinisrc} ${PHP_INI_FILE}

	dodir ${PHP_EXT_INI_DIR}
	dodir ${PHP_EXT_INI_DIR_ACTIVE}

	# Java needs to insert the correct ini files
	php_install_java_inifile

	# Install any extensions built as shared objects
	if useq sharedext ; then
		for x in `ls "${D}/${PHPEXTDIR}/"*.so | sort | sed -e "s|.*java.*||g"` ; do
			inifilename=${x/.so/.ini}
			inifilename=`basename ${inifilename}`
			echo "extension=`basename ${x}`" >> "${D}/${PHP_EXT_INI_DIR}/${inifilename}"
			dosym "${PHP_EXT_INI_DIR}/${inifilename}" "${PHP_EXT_INI_DIR_ACTIVE}/${inifilename}"
		done
	fi
}

# ========================================================================
# EXPORTED FUNCTIONS
# ========================================================================

php4_4-sapi_pkg_setup() {
	# let's do all the USE flag testing before we do anything else
	# this way saves a lot of time
	php4_4-sapi_check_awkward_uses
}

php4_4-sapi_src_unpack() {
	if [[ "${PHP_PACKAGE}" == 1 ]] ; then
		unpack ${A}
	fi

	cd "${S}"

	# Change PHP branding
	PHPPR=${PR/r/}
	if [[ "${PHPPR}" != "0" ]] ; then
		sed -e "s|^EXTRA_VERSION=\"\"|EXTRA_VERSION=\"-pl${PHPPR}-gentoo\"|g" -i configure.in || die "Unable to change PHP branding to -pl${PHPPR}-gentoo"
	else
		sed -e "s|^EXTRA_VERSION=\"\"|EXTRA_VERSION=\"-gentoo\"|g" -i configure.in || die "Unable to change PHP branding to -gentoo"
	fi

	# multilib-strict support
	if [[ -n "${MULTILIB_PATCH}" ]] && [[ -f "${WORKDIR}/${MULTILIB_PATCH}" ]] ; then
		epatch "${WORKDIR}/${MULTILIB_PATCH}"
	else
		ewarn "There is no multilib-strict patch available for this PHP release yet!"
	fi

	# Apply general PHP4 patches
	if [[ -d "${WORKDIR}/${MY_PHP_PV}/php4" ]] ; then
		EPATCH_SOURCE="${WORKDIR}/${MY_PHP_PV}/php4" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
	fi

	# Apply version-specific PHP patches
	if [[ -d "${WORKDIR}/${MY_PHP_PV}/${MY_PHP_PV}" ]] ; then
		EPATCH_SOURCE="${WORKDIR}/${MY_PHP_PV}/${MY_PHP_PV}" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
	fi

	# Patch PHP to show Gentoo as the server platform
	sed -e "s/PHP_UNAME=\`uname -a | xargs\`/PHP_UNAME=\`uname -s -n -r -v | xargs\`/g" -i configure.in || die "Failed to fix server platform name"

	# Disable interactive make test
	sed -e 's/'`echo "\!getenv('NO_INTERACTION')"`'/false/g' -i run-tests.php

	# Stop PHP from activating the Apache config, as we will do that ourselves
	for i in configure sapi/apache/config.m4 sapi/apache2filter/config.m4 sapi/apache2handler/config.m4 ; do
		sed -i.orig -e 's,-i -a -n php,-i -n php,g' ${i}
		sed -i.orig -e 's,-i -A -n php,-i -n php,g' ${i}
	done

	# Patch PHP to support heimdal instead of mit-krb5
	if has_version "app-crypt/heimdal" ; then
		sed -e 's|gssapi_krb5|gssapi|g' -i acinclude.m4 || die "Failed to fix heimdal libname"
		sed -e 's|PHP_ADD_LIBRARY(k5crypto, 1, $1)||g' -i acinclude.m4 || die "Failed to fix heimdal crypt library reference"
	fi

	# Patch for PostgreSQL support
	if useq postgres ; then
		sed -e 's|include/postgresql|include/postgresql include/postgresql/pgsql|g' -i ext/pgsql/config.m4 || die "Failed to fix PostgreSQL include paths"
	fi

	# Hardened-PHP support 
	if useq hardenedphp ; then
		if [[ -n "${HARDENEDPHP_PATCH}" ]] && [[ -f "${DISTDIR}/${HARDENEDPHP_PATCH}" ]] ; then
			epatch "${DISTDIR}/${HARDENEDPHP_PATCH}"
		else
			ewarn "There is no Hardened-PHP patch available for this PHP release yet!"
		fi
	fi

	# fastbuild support
	if useq fastbuild ; then
		if [[ -n "${FASTBUILD_PATCH}" ]] && [[ -f "${WORKDIR}/${FASTBUILD_PATCH}" ]] ; then
			epatch "${WORKDIR}/${FASTBUILD_PATCH}"
		else
			ewarn "There is no fastbuild patch available for this PHP release yet!"
		fi
	fi

	# Fix configure scripts to correctly support Hardened-PHP
	einfo "Running aclocal"
	WANT_AUTOMAKE=1.9 aclocal --force || die "Unable to run aclocal successfully"
	einfo "Running libtoolize"
	libtoolize --copy --force || die "Unable to run libtoolize successfully"

	# Rebuild configure to make sure it's up to date
	einfo "Rebuilding configure script"
	WANT_AUTOCONF=2.5 autoreconf --force -W no-cross || die "Unable to regenerate configure script successfully"

	# Run elibtoolize
	elibtoolize

	# Just in case ;-)
	chmod 0755 configure || die "Failed to chmod configure to 0755"
}

php4_4-sapi_src_compile() {
	destdir=/usr/$(get_libdir)/php4
	php4_4-sapi_set_php_ini_dir

	cd "${S}"
	confutils_init

	my_conf="${my_conf} --with-config-file-path=${PHP_INI_DIR} --with-config-file-scan-dir=${PHP_EXT_INI_DIR_ACTIVE} --without-pear"

	#							extension		USE flag		shared support?
	enable_extension_enable		"bcmath"		"bcmath"		1
	enable_extension_with		"bz2"			"bzip2"			1
	enable_extension_enable		"calendar"		"calendar"		1
	enable_extension_disable	"ctype"			"ctype"			0
	enable_extension_with		"curl"			"curl"			1
	enable_extension_enable		"dbase"			"dbase"			1
	enable_extension_with		"dom"			"xml"			0
	enable_extension_enable		"exif"			"exif"			1
	enable_extension_with		"fbsql"			"frontbase"		1
	enable_extension_with		"fdftk"			"fdftk"			1 "/opt/fdftk-6.0"
	enable_extension_enable		"filepro"		"filepro"		1
	enable_extension_enable		"ftp"			"ftp"			1
	enable_extension_with		"gettext"		"nls"			1
	enable_extension_with		"gmp"			"gmp"			1
	enable_extension_with		"hwapi"			"hyperwave-api"	1
	enable_extension_with		"iconv"			"iconv"			1
	enable_extension_with		"informix"		"informix"		1
	enable_extension_disable	"ipv6"			"ipv6"			0
	# ircg extension not supported on Gentoo at this time
	enable_extension_with		"kerberos"		"kerberos"		0 "/usr"
	enable_extension_enable		"mbstring"		"nls"			1
	enable_extension_with		"mcal"			"mcal"			1 "/usr"
	enable_extension_with		"mcrypt"		"crypt"			1
	enable_extension_with		"mcve"			"mcve"			1
	enable_extension_enable		"memory-limit"	"memlimit"		0
	enable_extension_with		"mhash"			"mhash"			1
	enable_extension_with		"ming"			"ming"			1
	enable_extension_with		"mnogosearch"	"mnogosearch"	1
	enable_extension_with		"msql"			"msql"			1
	enable_extension_with		"mssql"			"mssql"			1
	enable_extension_with		"ncurses"		"ncurses"		1
	enable_extension_with		"oci8"			"oci8"			1
	enable_extension_with		"oci8-instant-client"	"oci8-instant-client"	1
	enable_extension_with		"oracle"		"oracle7"		1
	enable_extension_with		"openssl"		"ssl"			0
	enable_extension_with		"openssl-dir"	"ssl"			0 "/usr"
	enable_extension_disable	"overload"		"overload"		0
	enable_extension_with		"ovrimos"		"ovrimos"		1
	enable_extension_enable		"pcntl" 		"pcntl" 		1
	enable_extension_without	"pcre-regex"	"pcre"			0
	enable_extension_with		"pfpro"			"pfpro"			1
	enable_extension_with		"pgsql"			"postgres"		1
	enable_extension_disable	"posix"			"posix"			1
	enable_extension_with		"pspell"		"spell"			1
	enable_extension_with		"recode"		"recode"		1
	enable_extension_enable		"shmop"			"sharedmem"		0
	enable_extension_with		"snmp"			"snmp"			1
	enable_extension_enable		"sockets"		"sockets"		1
	enable_extension_with		"sybase"		"sybase"		1
	enable_extension_with		"sybase-ct"		"sybase-ct"		1
	enable_extension_enable		"sysvmsg"		"sysvipc"		1
	enable_extension_enable		"sysvsem"		"sysvipc"		1
	enable_extension_enable		"sysvshm"		"sysvipc"		1
	enable_extension_disable	"tokenizer"		"tokenizer"		1
	enable_extension_enable		"wddx"			"wddx"			1
	enable_extension_disable	"xml"			"expat"			0
	enable_extension_with		"xmlrpc"		"xmlrpc"		1
	enable_extension_with		"zlib"			"zlib"			1
	enable_extension_enable		"debug"			"debug"			0

	# DBA support
	enable_extension_enable		"dba"		"dba"		1

	if useq dba ; then
		enable_extension_with "cdb"			"cdb"		1
		enable_extension_with "db4"			"berkdb"	1
		enable_extension_with "flatfile"	"flatfile"	1
		enable_extension_with "gdbm"		"gdbm"		1
		enable_extension_with "inifile"		"inifile"	1
	fi

	# DBX support
	if useq dbx ; then
		enable_extension_enable	"dbx"		"dbx"		1
	fi

	# Support for the GD graphics library
	if useq gd-external ; then
		enable_extension_with	"freetype-dir"	"truetype"		0 "/usr"
		enable_extension_with	"t1lib"			"truetype"		0 "/usr"
		enable_extension_enable	"gd-jis-conv"	"cjk" 			0
		enable_extension_enable	"gd-native-ttf"	"truetype"		0
		enable_extension_with 	"gd" 			"gd-external"	1 "/usr"
	else
		enable_extension_with	"freetype-dir"	"truetype"		0 "/usr"
		enable_extension_with	"t1lib"			"truetype"		0 "/usr"
		enable_extension_enable	"gd-jis-conv"	"cjk"			0
		enable_extension_enable	"gd-native-ttf"	"truetype"		0
		enable_extension_with	"jpeg-dir"		"gd"			0 "/usr"
		enable_extension_with 	"png-dir" 		"gd" 			0 "/usr"
		enable_extension_with 	"tiff-dir" 		"tiff" 			0 "/usr"
		enable_extension_with 	"xpm-dir" 		"xpm" 			0 "/usr/X11R6"
		# enable gd last, so configure can pick up the previous settings
		enable_extension_with 	"gd" 			"gd" 			0
	fi

	# Java support
	if useq java-internal ; then
		enable_extension_with	"java"			"java-internal"		0 "`java-config --jdk-home`"
	fi

	# IMAP support
	if useq imap ; then
		enable_extension_with	"imap"			"imap"			1
		enable_extension_with	"imap-ssl"		"ssl"			0
	fi

	# Interbase support
	if useq firebird || useq interbase ; then
		my_conf="${my_conf} --with-interbase=/usr"
	fi

	# LDAP support
	if useq ldap ; then
		enable_extension_with	"ldap"			"ldap"			1
	fi

	# MySQL support
	# In PHP4 MySQL is enabled by default, so if no 'mysql' USE flag is set,
	# we must turn it off.
	if ! useq mysql ; then
		enable_extension_without	"mysql"		"mysql"			1 "/usr"
	fi
	if useq mysql ; then
		enable_extension_with	"mysql"			"mysql"			1 "/usr"
		enable_extension_with	"mysql-sock"	"mysql"			0 "/var/run/mysqld/mysqld.sock"
	fi

	# ODBC support
	if useq odbc ; then
		enable_extension_with		"unixODBC"		"odbc"			1 "/usr"

		enable_extension_with		"adabas"		"adabas"		1
		enable_extension_with		"birdstep"		"birdstep"		1
		enable_extension_with		"dbmaker"		"dbmaker"		1
		enable_extension_with		"empress"		"empress"		1
		if useq empress ; then
			enable_extension_with	"empress-bcs"	"empress-bcs"	0
		fi
		enable_extension_with		"esoob"			"esoob"			1
		enable_extension_with		"ibm-db2"		"db2"			1
		enable_extension_with		"iodbc"			"iodbc"			1 "/usr"
		enable_extension_with		"sapdb"			"sapdb"			1
		enable_extension_with		"solid"			"solid"			1
	fi

	# readline/libedit support
	# you can use readline or libedit, but you can't use both
	enable_extension_with		"readline"		"readline"		0
	enable_extension_with		"libedit"		"libedit"		1

	# Sablotron/XSLT support
	enable_extension_enable		"xslt"			"xsl"			1
	enable_extension_with		"xslt-sablot"	"xsl"			1
	if useq xml ; then
		enable_extension_with		"dom-xslt"		"xsl"			0 	"/usr"
		enable_extension_with		"dom-exslt"		"xsl"			0	"/usr"
	fi

	# Session support
	if ! useq session ; then
		enable_extension_disable	"session"	"session"		1
	else
		enable_extension_with		"mm"		"sharedmem"		0
	fi

	# Fix ELF-related problems
	if useq pic ; then
		einfo "Enabling PIC support"
		my_conf="${my_conf} --with-pic"
	fi

	# apache2 & threads support
	if useq apache2 && useq threads ; then
		my_conf="${my_conf} --enable-experimental-zts"
		ewarn "Enabling ZTS for Apache2 MPM"
	fi

	# Catch CFLAGS problems
	php_check_cflags

	# multilib support
	if [[ $(get_libdir) != lib ]] ; then
		my_conf="--with-libdir=$(get_libdir) ${my_conf}"
	fi

	# We don't use econf, because we need to override all of its settings
	./configure --prefix=${destdir} --sysconfdir=/etc --cache-file=./config.cache ${my_conf} || die "configure failed"
	emake || die "make failed"
}

php4_4-sapi_src_install() {
	destdir=/usr/$(get_libdir)/php4

	cd "${S}"
	addpredict /usr/share/snmp/mibs/.index

	PHP_INSTALLTARGETS="install-build install-headers install-programs"
	useq sharedext && PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-modules"
	make INSTALL_ROOT="${D}" ${PHP_INSTALLTARGETS} || die "install failed"

	# Get the extension dir
	PHPEXTDIR="`"${D}/${destdir}/bin/php-config" --extension-dir`"

	# Don't forget the php.ini file
	local phpinisrc=php.ini-dist
	einfo "Setting extension_dir in php.ini"
	sed -e "s|^extension_dir .*$|extension_dir = ${PHPEXTDIR}|g" -i ${phpinisrc}

	# A patch for PHP for security
	einfo "Securing fopen wrappers"
	sed -e 's|^allow_url_fopen .*|allow_url_fopen = Off|g' -i ${phpinisrc}

	# Set the include path to point to where we want to find PEAR packages
	einfo "Setting correct include_path"
	sed -e 's|^;include_path = ".:/php/includes".*|include_path = ".:/usr/share/php4:/usr/share/php"|' -i ${phpinisrc}

	# Java module and support needs to be installed
	php_install_java

	# Create the directory where we'll put php4-only php scripts
	keepdir /usr/share/php4
}

php4_4-sapi_pkg_postinst() {
	# Update Apache1 to use mod_php
	if useq apache ; then
		"${ROOT}/usr/sbin/php-select" -t apache1 php4 > /dev/null 2>&1
		exitStatus=$?
		if [[ ${exitStatus} == 2 ]] ; then
			php-select apache1 php4
		elif [[ ${exitStatus} == 4 ]] ; then
			ewarn
			ewarn "Apache 1 is configured to load a different version of PHP."
			ewarn "To make Apache 1 use PHP v4, use php-select:"
			ewarn
			ewarn "   php-select apache1 php4"
			ewarn
		fi
	fi

	# Update Apache2 to use mod_php
	if useq apache2 ; then
		"${ROOT}/usr/sbin/php-select" -t apache2 php4 > /dev/null 2>&1
		exitStatus=$?
		if [[ ${exitStatus} == 2 ]] ; then
			php-select apache2 php4
		elif [[ ${exitStatus} == 4 ]] ; then
			ewarn
			ewarn "Apache 2 is configured to load a different version of PHP."
			ewarn "To make Apache 2 use PHP v4, use php-select:"
			ewarn
			ewarn "   php-select apache2 php4"
			ewarn
		fi
	fi

	# Create the symlinks for php-cli
	if useq cli ; then
		"${ROOT}/usr/sbin/php-select" -t php php4 > /dev/null 2>&1
		exitStatus=$?
		if [[ ${exitStatus} == 5 ]] ; then
			php-select php php4
		elif [[ ${exitStatus} == 4 ]] ; then
			ewarn
			ewarn "/usr/bin/php links to a different version of PHP."
			ewarn "To make /usr/bin/php point to PHP v4, use php-select:"
			ewarn
			ewarn "   php-select php php4"
			ewarn
		fi
	fi

	# Create the symlinks for php-cgi
	if useq cgi ; then
		"${ROOT}/usr/sbin/php-select" -t php-cgi php4 > /dev/null 2>&1
		exitStatus=$?
		if [[ ${exitStatus} == 5 ]] ; then
			php-select php-cgi php4
		elif [[ ${exitStatus} == 4 ]] ; then
			ewarn
			ewarn "/usr/bin/php-cgi links to a different version of PHP."
			ewarn "To make /usr/bin/php-cgi point to PHP v4, use php-select:"
			ewarn
			ewarn "   php-select php-cgi php4"
			ewarn
		fi
	fi

	# Create the symlinks for php-devel
	"${ROOT}/usr/sbin/php-select" -t php-devel php4 > /dev/null 2>&1
	exitStatus=$?
	if [[ $exitStatus == 5 ]] ; then
		php-select php-devel php4
	elif [[ $exitStatus == 4 ]] ; then
		ewarn
		ewarn "/usr/bin/php-config and/or /usr/bin/phpize are linked to a"
		ewarn "different version of PHP. To make them point to PHP v4, use"
		ewarn "php-select:"
		ewarn
		ewarn "   php-select php-devel php4"
		ewarn
	fi

	ewarn "If you have additional third party PHP extensions (such as"
	ewarn "dev-php4/phpdbg) you may need to recompile them now."
	ewarn "A new way of enabling/disabling PHP extensions was introduced"
	ewarn "with the newer PHP packages releases, so please reemerge any"
	ewarn "PHP extensions you have installed to automatically adapt to"
	ewarn "the new configuration layout."
	if useq sharedext ; then
		ewarn "The core PHP extensions are now loaded through external"
		ewarn ".ini files, not anymore using a 'extension=name.so' line"
		ewarn "in the php.ini file. Portage will take care of this by"
		ewarn "creating new, updated config-files, please make sure to"
		ewarn "install those using etc-update or dispatch-conf."
	fi
	ewarn

	if useq curl; then
		ewarn "Please be aware that CURL can allow the bypass of open_basedir restrictions."
		ewarn "This can be a security risk!"
		ewarn
	fi

	ewarn "The 'pic' USE flag was added to newer releases of dev-lang/php."
	ewarn "With PIC enabled, your PHP installation may become slower, but"
	ewarn "PIC is required on Hardened-Gentoo platforms (where the USE flag"
	ewarn "is enabled automatically). You may also need this on other"
	ewarn "configurations where you disabled TEXTRELs, for example using"
	ewarn "PaX in the kernel."
	ewarn

	ewarn "The 'xml' and 'xml2' USE flags were unified in only the 'xml' USE"
	ewarn "flag. To get the features that were once controlled by the 'xml2'"
	ewarn "USE flag, turn the 'xml' USE flag on. To get the features that were"
	ewarn "once controlled by the 'xml' USE flag, turn the 'expat' USE flag on."
	ewarn
}
