# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php5-sapi.eclass,v 1.6 2004/07/21 10:42:41 stuart Exp $
#
# eclass/php5-sapi.eclass
#		Eclass for building different php5 SAPI instances
#
#		Based on robbat2's work on the php4 sapi eclass
#
# Author(s)		Stuart Herbert
#				<stuart@gentoo.org>
#
# ========================================================================

inherit confutils

ECLASS=php5-sapi
INHERITED="$INHERITED $ECLASS"

# set MY_P in the ebuild

HOMEPAGE="http://www.php.net/"
LICENSE="PHP"
SRC_URI="http://www.php.net/distributions/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"
IUSE="${IUSE} adabas bcmath birdstep bzlib calendar cpdflib crypt ctype curl curlwrappers db2 dbase dbmaker dbx dio esoob exif fam frontbase fdftk filepro ftp gmp hyperwave-api iconv informix ingres interbase iodbc jpeg libedit mcve mhash ming mnogosearch msession msql mssql mysql ncurses nls nis oci8 oracle7 ovrimos pcre pfpro png postgres posix readline recode sapdb session shared simplexml snmp soap sockets solid spell spl ssl sybase sybase-ct sysvipc tidy tiff tokenizer truetype odbc wddx xsl xml2 xmlrpc zlib dba cdb berkdb flatfile gdbm inifile qdbm empress empress-bcs gd gd-external imap kerberos ldap sasl pcntl sqlite"

# these USE flags should have the correct dependencies

DEPEND="$DEPEND
	!<=dev-php/php-4.99.99
	bzlib? ( app-arch/bzip2 )
	crypt? ( >=dev-libs/libmcrypt-2.4 >=app-crypt/mhash-0.8 )
	curl? ( >=net-misc/curl-7.10.2 )
	fam? ( app-admin/fam )
	fdftk? ( app-text/fdftk )
	gd-external? ( media-libs/gd )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	gmp? ( dev-libs/gmp )
	iconv? ( dev-libs/libiconv )
	imap? ( virtual/imapd )
	jpeg? ( >=media-libs/jpeg-6b )
	ldap? ( >=net-nds/openldap-1.2.11 )
	mhash? ( app-crypt/mhash )
	ming? ( media-libs/ming )
	mysql? ( >=dev-db/mysql-3.23.26 )
	mysqli? ( >=dev-db/mysql-4.0.18 )
	ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	postgres? ( >=dev-db/postgresql-7.1 )
	readline? ( sys-libs/readline )
	recode? ( app-text/recode )
	simplexml? ( dev-libs/libxml2 )
	snmp? ( virtual/snmp )
	soap? ( dev-libs/libxml2 )
	spell? ( app-text/aspell )
	sqlite? ( dev-db/sqlite )
	ssl? ( >=dev-libs/openssl-0.9.7 )
	sybase? ( dev-db/freetds )
	tidy? ( app-text/htmltidy )
	wddx? ( dev-libs/expat )
	xml2? ( dev-libs/libxml2 )
	xsl? ( dev-libs/libxslt )
	zlib? ( sys-libs/zlib )"

# these USE flags have not yet been sorted out

	#berkdb?
	#cpdflib?
	#dbmaker?
	#esoodb?
	#iodbc?
	#kerberos?
	#solid?
	#xmlrpc?

# ========================================================================

PHP_BUILDTARGETS="${PHP_BUILDTARGETS} build-modules"
PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install"

# ========================================================================

# we make the CLI version of PHP responsible for a few things,
# such as the files required by PEAR

PHP_PROVIDER_PKG="dev-php/php"
PHP_PROVIDER_PKG_MINPVR="5.0.0"

# ========================================================================

PHP_INI_DIR="/etc/php/${PHPSAPI}-php5"
PHP_INI_FILE="php.ini"

# ========================================================================

EXPORT_FUNCTIONS pkg_setup src_compile src_install src_unpack

# ========================================================================
# INTERNAL FUNCTIONS
# ========================================================================

php5-sapi_check_awkward_uses () {

	if useq dba ; then
		#                     extension     USE flag    shared support?
		enable_extension_with "cdb"			"cdb"		1
		enable_extension_with "db4"			"berkdb"	1
		enable_extension_with "dbm"			"dbm"		1
		enable_extension_with "flatfile"	"flatfile"	1
		enable_extension_with "gdbm"		"gdbm"		1
		enable_extension_with "inifile"		"inifile"	1
		enable_extension_with "qdbm"		"qdbm"		1
	fi

	if useq gd-external ; then
		enable_extension_with "gd" "gd-external" 1 "/usr"
		enable_extension_enable	"gd-jis-conf"	"nls" 0
		enable_extension_enable	"gd-native-ttf"	"truetype" 0
	else
		enable_extension_with	"freetype-dir"	"truetype"	0
		enable_extension_with	"t1lib"			"truetype"	0 
		enable_extension_enable	"gd-jis-conf"	"nls"		0
		enable_extension_enable	"gd-native-ttf"	"truetype"	0
		enable_extension_with 	"jpeg-dir" 		"jpeg" 		0 "/usr"
		enable_extension_with 	"png-dir" 		"png" 		0 "/usr"
		enable_extension_with 	"tiff-dir" 		"tiff" 		0 "/usr"
		enable_extension_with 	"xpm-dir" 		"xpm" 		0 "/usr"
		# enable gd last, so configure can pick up the previous settings
		enable_extension_with "gd" "gd" 0
	fi

	if useq imap ; then
		enable_extension_with "imap" "imap" 1
		enable_extension_with "kerberos" "kerberos" 1
		enable_extension_with "imap-ssl" "ssl" 1
	fi

	if useq ldap ; then
		enable_extension_with "ldap" "ldap" 1
		enable_extension_with "ldap-sasl" "sasl" 1
	fi

	if useq odbc ; then
		enable_extension_with		"unixODBC"		"odbc"			1

		enable_extension_with		"adabas"		"adabas"		1
		enable_extension_with		"birdstep"		"birdstep"		1
		enable_extension_with		"dbmaker"		"dbmaker"		1
		enable_extension_with		"empress"		"empress"		1
		if useq empress ; then
			enable_extension_with	"empress-bcs"	"empress-bcs"	0
		fi
		enable_extension_with		"esoob"			"esoob"			1
		enable_extension_with		"ibm-db2"		"db2"			1
		enable_extension_with		"iodbc"			"iodbc"			1
		enable_extension_with		"sapdb"			"sapdb"			1
		enable_extension_with		"solid"			"solid"			1
	fi

	if useq mysql ; then
		enable_extension_with		"mysql"			"mysql"			1
	else
		enable_extension_with		"mysqli"		"mysql"			1
	fi

	case "$PHPSAPI" in
		cli|cgi)
			enable_extension_with "pcntl" "pcntl" 1 ;;
	esac

	confutils_use_conflict "readline" "libedit"

	confutils_use_conflict "recode" "mysql" "nis"

	if ! useq session ; then
		enable_extension_disable	"session"		"session"		1
	else
		enable_extension_with		"msession"		"msession"		1
	fi

	if ! useq sqlite ; then
		enable_extension_without	"sqlite"	"sqlite"	0
	else
		enable_extension_enable		"sqlite-utf8"	"nls"	0
	fi

	confutils_use_depend_all "cdb"		"dba"
	confutils_use_depend_all "db4"		"dba"
	confutils_use_depend_all "flatfile"	"dba"
	confutils_use_depend_all "gdbm"		"dba"
	confutils_use_depend_all "inifile"	"dba"
	confutils_use_depend_all "qdbm"		"dba"

	confutils_use_depend_any "exif" "jpeg" "tiff"

	# GD library support
	confutils_use_depend_any "truetype" "gd" "gd-external"
	
	# imap support
	confutils_use_depend_all "kerberos" "imap"

	# ldap support
	confutils_use_depend_all "sasl" "ldap"

	# mysql support
	confutils_use_conflict "mysqli" "mysql"

	# odbc support
	confutils_use_depend_all "adabas"		"odbc"
	confutils_use_depend_all "birdstep"		"odbc"
	confutils_use_depend_all "dbmaker"		"odbc"
	confutils_use_depend_all "empress"		"odbc"
	confutils_use_depend_all "empress-bcs"	"odbc" "empress"
	confutils_use_depend_all "esoob"		"odbc"
	confutils_use_depend_all "db2"			"odbc"
	confutils_use_depend_all "sapdb"		"odbc"
	confutils_use_depend_all "solid"		"odbc"

	# session support
	confutils_use_depend_all "mm"		"session"
	confutils_use_depend_all "msession"	"session"

	confutils_warn_about_missing_deps
}

# are we the CLI ebuild or not?
# used to conditionally install a few things

php5-sapi_is_providerbuild () {
	if [ "${CATEGORY}/${PN}" == "${PHP_PROVIDER_PKG}" ]; then
		return 0
	else
		return 1
	fi
}

# ========================================================================
# EXPORTED FUNCTIONS
# ========================================================================

php5-sapi_pkg_setup () {
	# let's do all the USE flag testing before we do anything else
	# this way saves a lot of time

	php5-sapi_check_awkward_uses
}

php5-sapi_src_unpack () {
	unpack ${A}
	cd ${S}

	# Patch PHP to show Gentoo as the server platform
	sed -i "s/PHP_UNAME=\`uname -a\`/PHP_UNAME=\`uname -s -n -r -v\`/g" configure
	# Patch for PostgreSQL support
	sed -e 's|include/postgresql|include/postgresql include/postgresql/pgsql|g' -i configure

	# Patch for session persistence bug
	epatch ${FILESDIR}/php5_soap_persistence_session.diff

    # stop php from activating the apache config, as we will do that ourselves
	for i in configure sapi/apache/config.m4 sapi/apache2filter/config.m4 sapi/apache2handler/config.m4 ; do
		sed -i.orig -e 's,-i -a -n php5,-i -n php5,g' $i
	done

	# Just in case ;-)
	chmod 755 configure
}

php5-sapi_src_compile () {

	confutils_init

	my_conf="${my_conf} --with-config-file-path=${PHP_INI_DIR}"
	php5-sapi_is_providerbuild || my_conf="${my_conf} --without-pear"

	#							extension		USE flag		shared support?
	enable_extension_enable		"bcmath"		"bcmath"		1
	enable_extension_with		"bz2"			"bzlib"			1
	enable_extension_enable		"calendar"		"calendar"		1
	enable_extension_with		"cpdflib"		"cpdflib"		1
	enable_extension_disable	"ctype"			"ctype"			0
	enable_extension_with		"curl"			"curl"			1
	enable_extension_with		"curlwrappers"	"curlwrappers"	1
	enable_extension_enable		"dbase"			"dbase"			1
	enable_extension_enable		"dbx"			"dbx"			1
	enable_extension_enable		"dio"			"dio"			1
	enable_extension_disable	"dom"			"xml2"			0
	enable_extension_enable		"exif"			"exif"			1
	enable_extension_with		"fam"			"fam"			1
	enable_extension_with		"fbsql"			"frontbase"		1
	enable_extension_with		"fdftk"			"fdftk"			1
	enable_extension_enable		"filepro"		"filepro"		1
	enable_extension_enable		"ftp"			"ftp"			1
	enable_extension_with		"gettext"		"nls"			1
	enable_extension_with		"gmp"			"gmp"			1
	enable_extension_with		"hwapi"			"hyperwave-api"	1
	enable_extension_with		"iconv"			"iconv"			1
	enable_extension_with		"informix"		"informix"		1
	enable_extension_with		"ingres"		"ingres"		1
	enable_extension_with		"interbase"		"interbase"		1
	# ircg extension not supported on Gentoo at this time
	enable_extension_disable	"libxml"		"xml2"			0
	enable_extension_enable		"mbstring"		"nls"			1
	enable_extension_with		"mcrypt"		"crypt"			1
	enable_extension_with		"mcve"			"mcve"			1
	enable_extension_with		"mhash"			"mhash"			1
	enable_extension_with		"ming"			"ming"			1
	enable_extension_with		"mnogosearch"	"mnogosearch"	1
	enable_extension_with		"msql"			"msql"			1
	enable_extension_with		"mssql"			"mssql"			1
	enable_extension_with		"ncurses"		"ncurses"		1
	enable_extension_with		"oci8"			"oci8"			1
	enable_extension_with		"oracle"		"oracle7"		1
	enable_extension_with		"openssl"		"ssl"			1
	enable_extension_with		"ovrimos"		"ovrimos"		1
	enable_extension_without	"pcre-regx"		"pcre"			1
	enable_extension_with		"pfpro"			"pfpro"			1
	enable_extension_with		"pgsql"			"postgres"		1
	enable_extension_disable	"posix"			"posix"			1
	enable_extension_with		"pspell"		"spell"			1
	enable_extension_with		"recode"		"recode"		1
	enable_extension_disable	"simplexml"		"simplexml"		1
	enable_extension_with		"snmp"			"snmp"			1
	enable_extension_enable		"soap"			"soap"			1
	enable_extension_enable		"sockets"		"sockets"		1
	enable_extension_disable	"spl"			"spl"			1
	enable_extension_with		"sybase"		"sybase"		1
	enable_extension_with		"sybase-ct"		"sybase-ct"		1
	enable_extension_enable		"sysvmsg"		"sysvipc"		1
	enable_extension_enable		"sysvsem"		"sysvipc"		1
	enable_extension_enable		"sysvshm"		"sysvipc"		1
	enable_extension_with		"tidy"			"tidy"			1
	enable_extension_disable	"tokenizer"		"tokenizer"		1
	enable_extension_enable		"wddx"			"wddx"			1
	enable_extension_with		"xsl"			"xsl"			1
	enable_extension_disable	"xml"			"xml2"			1
	enable_extension_with		"xmlrpc"		"xmlrpc"		1
	enable_extension_enable		"yp"			"nis"			1
	enable_extension_with		"zlib"			"zlib"			1

	php5-sapi_check_awkward_uses

	# DBA support

	enable_extension_enable		"dba"		"dba" 1

	# readline support
	#
	# you can use readline or libedit, but you can't use both
	enable_extension_with		"readline"		"readline"		0
	enable_extension_with		"libedit"		"libedit"		1


	echo "${my_conf}"
	// die "debugging output"

	econf ${my_conf} || die "configure failed"
	emake || die "make failed"
}

php5-sapi_src_install () {
	addpredict /usr/share/snmp/mibs/.index
	
	useq shared && PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-modules"
	make INSTALL_ROOT=${D} $PHP_INSTALLTARGETS || die "install failed"

	# annoyingly, we have to install the CLI by hand
	if [ "$PHPSAPI" = "cli" ]; then
		dobin sapi/cli/php
	fi

	# don't forget the php.ini file

	dodir ${PHP_INI_DIR}
	insinto ${PHP_INI_DIR}
	newins php.ini-dist ${PHP_INI_FILE}

	# we only install the following for the PHP_PROVIDER_PKG ebuild

	if ! php5-sapi_is_providerbuild ; then
		rm ${D}/usr/bin/php-config
		rm ${D}/usr/bin/phpize
		rm ${D}/usr/bin/phpextdist
		rm -rf ${D}/usr/lib/php/build
		rm -rf ${D}/usr/include/php
		rm -rf ${D}/usr/share/man/man1/php.1*
	fi
}
