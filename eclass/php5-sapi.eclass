# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php5-sapi.eclass,v 1.1 2004/06/27 18:30:09 stuart Exp $
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

HOMEPAGE="http://www.php.net/"
SRC_URI="http://www.php.net/distributions/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"
IUSE="${IUSE} adabas bcmath birdstep bzlib calendar cpdflib crypt ctype curl curlwrappers db2 dbase dbmaker dbx dio esoob exif fam frontbase fdftk filepro ftp gmp hyperwave-api iconv informix ingres interbase iodbc libedit mcve mhash ming mnogosearch msession msql mssql mysql ncurses nls nis oci8 oracle7 ssl ovrimos pcre pfpro postgres posix readline recode sapdb session shared simplexml snmp soap sockets solid spell spl ssl sybase sybase-ct sysvipc tidy tokenizer truetype odbc wddx xsl xml2 xmlrpc zlib dba cdb berkdb flatfile gdbm inifile qdbm empress empress-bcs gd gd-external imap kerberos ssl ldap sasl pcntl mmap sqlite"
DEPEND="$DEPEND
	readline? ( sys-libs/readline )"

# ========================================================================

PHP_BUILDTARGETS="${PHP_BUILDTARGETS} build-modules"
PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install"

# ========================================================================

EXPORT_FUNCTIONS src_compile src_install

# ========================================================================
# EXPORTED FUNCTIONS
# ========================================================================

php5-sapi_src_compile () {

	confutils_init

	my_conf="${my_conf} --with-config-file-path=/etc/php/${PHPSAPI}-php5/php.ini"

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
	enable_extension_with		"soap"			"soap"			1
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

	# DBA support
	confutils_use_depend_all "cdb"		"dba"
	confutils_use_depend_all "db4"		"dba"
	confutils_use_depend_all "flatfile"	"dba"
	confutils_use_depend_all "gdbm"		"dba"
	confutils_use_depend_all "inifile"	"dba"
	confutils_use_depend_all "qdbm"		"dba"

	enable_extension_enable		"dba"		"dba" 1

	if useq dba ; then
		#                     extension     USE flag    shared support?
		enable_extension_with "cdb"			"cdb"		1
		enable_extension_with "db4"			"berkdb"	1
		enable_extension_with "dbm"			"dbm"		1
		enable_extension_with "flatfile"	"flatfile"	1
		enable_extension_with "gdbm"		"gdbm"		1
		enable_extension_with "inifile"		"inifile"	1
		enable_extension_with "ndbm"		"ndbm"		1
		enable_extension_with "qdbm"		"qdbm"		1
	fi

	# GD library support

	confutils_use_depend_any "truetype" "gd" "gd-external"

	if useq gd-external ; then
		enable_extension_with "gd" "gd-external" 1 "/usr"
		enable_extension_enable	"gd-jis-conf"	"nls" 0
		enable_extension_enable	"gd-native-ttf"	"truetype" 0
	else
		enable_extension_with "gd" "gd" 1
		enable_extension_enable	"gd-jis-conf"	"nls" 0
		enable_extension_enable	"gd-native-ttf"	"truetype" 0
	fi
	
	# imap support

	confutils_use_depend_all "kerberos" "imap"

	if useq imap ; then
		enable_extension_with "imap" "imap" 1
		enable_extension_with "kerberos" "kerberos" 1
		enable_extension_with "imap-ssl" "ssl" 1
	fi

	# ldap support

	confutils_use_depend_all "sasl" "ldap"

	if useq ldap ; then
		enable_extension_with "ldap" "ldap" 1
		enable_extension_with "ldap-sasl" "sasl" 1
	fi

	# mysql support
	confutils_use_conflict "mysqli" "mysql"

	if useq mysql ; then
		enable_extension_with		"mysql"			"mysql"			1
	else
		enable_extension_with		"mysqli"		"mysql"			1
	fi

	# odbc support
	confutils_use_depend_all "adabas"		"odbc"
	confutils_use_depend_all "birdstep"		"odbc"
	confutils_use_depend_all "dbmaker"		"odbc"
	confutils_use_depend_all "empress"		"odbc"
	confutils_use_depend_all "empress-bcs"	"odbc empress"
	confutils_use_depend_all "esoob"		"odbc"
	confutils_use_depend_all "db2"			"odbc"
	confutils_use_depend_all "sapdb"		"odbc"
	confutils_use_depend_all "solid"		"odbc"

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

	# pcntl support

	case "$PHPSAPI" in
		cli|cgi)
			enable_extension_with "pcntl" "pcntl" 1 ;;
	esac

	# readline support
	#
	# you can use readline or libedit, but you can't use both

	confutils_use_conflict "readline" "libedit"

	enable_extension_with		"readline"		"readline"		0
	enable_extension_with		"libedit"		"libedit"		1

	# session support

	confutils_use_depend_all "mm"		"session"
	confutils_use_depend_all "msession"	"session"

	if ! useq session ; then
		enable_extension_disable	"session"		"session"		1
	else
		enable_extension_with		"mm"			"mmap"			0
		enable_extension_with		"msession"		"msession"		1
	fi

	# sqlite support

	if ! useq sqlite ; then
		enable_extension_without	"sqlite"	"sqlite"	0
	else
		enable_extension_enable		"sqlite-utf8"	"nls"	0
	fi

	echo "$my_conf"

	econf ${my_conf} || die "configure failed"
	emake || die "make failed"
}

php5-sapi_src_install () {
	useq shared && PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-modules"
	make INSTALL_ROOT=${D} $PHP_INSTALLTARGETS || die "install failed"

	if [ "$PHPSAPI" = "cli" ]; then
		dobin sapi/cli/php
	fi
}
