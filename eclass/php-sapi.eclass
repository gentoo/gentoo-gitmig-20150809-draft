# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-sapi.eclass,v 1.14 2004/03/28 22:08:56 stuart Exp $
# Author: Robin H. Johnson <robbat2@gentoo.org>

inherit eutils flag-o-matic

ECLASS=php-sapi
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst pkg_preinst

[ -z "${MY_PN}" ] && MY_PN=php
if [ -z "${MY_PV}" ]; then
	MY_PV=${PV/_rc/RC}
	# maybe do stuff for beta/alpha/pre here too?
fi

# our major ver number
PHPMAJORVER=${MY_PV//\.*}

[ -z "${MY_P}" ] && MY_P=${MY_PN}-${MY_PV}
[ -z "${MY_PF}" ] && MY_PF=${MY_P}-${PR}
[ -z "${HOMEPAGE}" ] && HOMEPAGE="http://www.php.net/"
[ -z "${LICENSE}" ]	&& LICENSE="PHP"
[ -z "${PROVIDE}" ]	&& PROVIDE="virtual/php-${PV}"
# PHP.net does automatic mirroring from this URI
[ -z "${SRC_URI_BASE}" ] && SRC_URI_BASE="http://www.php.net/distributions"
if [ -z "${SRC_URI}" ]; then
	SRC_URI="${SRC_URI_BASE}/${MY_P}.tar.bz2"
fi
# A patch for PHP for security. PHP-CLI interface is exempt, as it cannot be
# fed bad data from outside.
if [ "${PHPSAPI}" != "cli" ]; then
	SRC_URI="${SRC_URI} mirror://gentoo/php-4.3.2-fopen-url-secure.patch"
fi

# Where we work
S=${WORKDIR}/${MY_P}

IUSE="${IUSE} X crypt curl firebird flash freetds gd gd-external gdbm imap informix ipv6 java jpeg ldap mcal memlimit mysql nls oci8 odbc pam pdflib png postgres qt snmp spell ssl tiff truetype xml2 yaz fdftk doc"

# berkdb stuff is complicated
# we need db-1.* for ndbm
# and then either of db3 or db4
IUSE="${IUSE} berkdb"
RDEPEND="${RDEPEND} berkdb? ( =sys-libs/db-1* 
							  || ( >=sys-libs/db-4.0.14-r2 
								   >=sys-libs/db-3.2.9-r9
							     ) 
							)"

# Everything is in this list is dynamically linked agaist or needed at runtime
# in some other way
#
# 2004/03/28 - stuart - added dependency on the php manual snapshot

RDEPEND="${RDEPEND}
   >=sys-libs/cracklib-2.7-r7
   app-arch/bzip2
   X? ( virtual/x11 )
   crypt? ( >=dev-libs/libmcrypt-2.4 >=app-crypt/mhash-0.8 )
   curl? ( >=net-ftp/curl-7.10.2 )
   x86? ( firebird? ( >=dev-db/firebird-1.0 ) )
   freetds? ( >=dev-db/freetds-0.53 )
   gd-external? ( media-libs/libgd >=media-libs/jpeg-6b 
                  >=media-libs/libpng-1.2.5 )
   gd? ( >=media-libs/jpeg-6b >=media-libs/libpng-1.2.5 )
   gdbm? ( >=sys-libs/gdbm-1.8.0 )
   !alpha? ( java? ( =virtual/jdk-1.4* dev-java/java-config ) )
   jpeg? ( >=media-libs/jpeg-6b )
   ldap? ( >=net-nds/openldap-1.2.11 )
   mysql? ( >=dev-db/mysql-3.23.26 )
   nls? ( sys-devel/gettext )
   odbc? ( >=dev-db/unixODBC-1.8.13 )
   pam? ( >=sys-libs/pam-0.75 )
   pdflib? ( >=media-libs/pdflib-4.0.3 >=media-libs/jpeg-6b 
             >=media-libs/libpng-1.2.5 >=media-libs/tiff-3.5.5 )
   png? ( >=media-libs/libpng-1.2.5 )
   postgres? ( >=dev-db/postgresql-7.1 )
   qt? ( >=x11-libs/qt-2.3.0 )
   snmp? ( virtual/snmp )
   spell? ( app-text/aspell )
   ssl? ( >=dev-libs/openssl-0.9.5 )
   tiff? ( >=media-libs/tiff-3.5.5 )
   xml2? ( dev-libs/libxml2 >=dev-libs/libxslt-1.0.30 )
   truetype? ( =media-libs/freetype-2* =media-libs/freetype-1* 
               media-libs/t1lib )
   >=net-libs/libwww-5.3.2
   >=app-text/sablotron-0.97
   dev-libs/expat
   sys-libs/zlib 
   virtual/mta
   sys-apps/file
   yaz? ( dev-libs/yaz )
   doc? ( app-doc/php-docs )"


# USE structure doesn't support ~x86
#if hasq '~x86' $ACCEPT_KEYWORDS; then
	# FDFTK only available for x86 type hardware
	#RDEPEND="${RDEPEND} x86? ( fdftk? ( app-text/fdftk ) )"
#fi

# libswf is ONLY available on x86
RDEPEND="${RDEPEND} flash? ( 
		x86? ( media-libs/libswf ) 
		>=media-libs/ming-0.2a )"

#The new XML extension in PHP5 requires libxml2-2.5.10
if [ "${PHPMAJORVER}" -ge 5 ]; then
	RDEPEND="${RDEPEND} >=dev-libs/libxml2-2.5.10"
fi

# ncurses and readline are only valid on the CLI php
if [ "${PN}" = "php" ]; then
	RDEPEND="${RDEPEND}
		readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
		ncurses? ( >=sys-libs/ncurses-5.1 )"
	IUSE="${IUSE} ncurses readline"
fi


# These are extra bits we need only at compile time
DEPEND="${RDEPEND} ${DEPEND}
	imap? ( virtual/imap-c-client )
	mcal? ( dev-libs/libmcal )"
#9libs causes a configure error
DEPEND="${DEPEND} !dev-libs/9libs"
#dev-libs/libiconv causes a compile failure
DEPEND="${DEPEND} !dev-libs/libiconv"

#Waiting for somebody to want this:
#cyrus? ( net-mail/cyrus-imapd net-mail/cyrus-imap-admin dev-libs/cyrus-imap-dev ) 

# this is because dev-php/php provides all of the PEAR stuff and some other
# required odds and ends, and only as of this version number.
PHP_PROVIDER_PKG="dev-php/php"
php-sapi_is_providerbuild() {
	if [ "${CATEGORY}/${PN}" == "${PHP_PROVIDER_PKG}" ]; then
		return 0
	else
		return 1
	fi
}
php-sapi_is_providerbuild || PDEPEND="${PDEPEND} >=${PHP_PROVIDER_PKG}-4.3.4-r2"

#export this here so we can use it
myconf="${myconf}"

# These are the standard targets that we want to for the install stage since we
# can't do the full 'make install' You may need to add your own items here for
# SAPIs etc.
PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-modules install-programs"
# provided by PHP Provider:
# install-pear install-build install-headers install-programs
# for use by other ebuilds:
# install-cli install-sapi install-modules install-programs
#
# all ebuilds should have install-programs, and then delete everything except
# php-config.${PN}

# These are quick fixups for older ebuilds that didn't have PHPSAPI defined.
[ -z "${PHPSAPI}" ] && [ "${PN}" = "php" ] && PHPSAPI="cli"
if [ -z "${PHPSAPI}" ] && [ "${PN}" = "mod_php" ]; then
	use apache2 && PHPSAPI="apache2" || PHPSAPI="apache1"
fi

# Now enforce existance of PHPSAPI
if [ -z "${PHPSAPI}" ]; then
	msg="The PHP eclass needs a PHPSAPI setting!"
	eerror "${msg}"
	die "${msg}"
fi
# build the destination and php.ini detail
PHPINIDIRECTORY="/etc/php/${PHPSAPI}-php${PHPMAJORVER}"
PHPINIFILENAME="php.ini"

php-sapi_check_java_config() {
	JDKHOME="`java-config --jdk-home`"
	NOJDKERROR="You need to use java-config to set your JVM to a JDK!"
	if [ -z "${JDKHOME}" ] || [ ! -d "${JDKHOME}" ]; then
		eerror "${NOJDKERROR}"
		die "${NOJDKERROR}"
	fi

	# stuart@gentoo.org - 2003/05/18
	# Kaffe JVM is not a drop-in replacement for the Sun JDK at this time

	if echo $JDKHOME | grep kaffe > /dev/null 2>&1 ; then
		eerror
		eerror "PHP will not build using the Kaffe Java Virtual Machine."
		eerror "Please change your JVM to either Blackdown or Sun's."
		eerror 
		eerror "To build PHP without Java support, please re-run this emerge"
		eerror "and place the line:"
		eerror "  USE='-java'"
		eerror "in front of your emerge command; e.g."
		eerror "  USE='-java' emerge mod_php"
		eerror
		eerror "or edit your USE flags in /etc/make.conf"
		die
	fi

	JDKVER="$(java-config --java-version 2>&1 | head -n1 | cut -d\" -f2)"
	einfo "JDK version: ${JDKVER}"
	if [ -n "${JDKVER/1.4.*}" -o -z "${JDKVER}" ]; then
		eerror "Please ensure that you have a JDK with a version of at least"
		eerror "1.4 selected using java-config"
		die
	fi
}

php-sapi_src_unpack() {
	use xml || \
	( ewarn "You have the xml USE flag turned off. Previously this"
	  ewarn "disabled XML support in PHP. However PEAR has a hard"
	  ewarn "dependancy on it, so they are now enabled." )
	if use fdftk; then
		has_version app-text/fdftk || \
		die "app-text/fdftk is required for FDF support! Portage isn't up to the DEPEND structure for it yet"
	fi

	unpack ${MY_P}.tar.bz2
	cd ${S}

	# Configure Patch for hard-wired uname -a
	sed "s/PHP_UNAME=\`uname -a\`/PHP_UNAME=\`uname -s -n -r -v\`/g" -i configure
	# ensure correct perms on configure
	chmod 755 configure


	# no longer needed and breaks pear - Tal, 20031223
	
	# fix PEAR installer for our packaging
	# we keep a backup of it as we need it at the end of the install
	#cp pear/PEAR/Registry.php pear/PEAR/Registry.old
	#sed -e "s:\$pear_install_dir\.:\'${D}/usr/lib/php/\' . :g" -i pear/PEAR/Registry.php

	sed -e 's|include/postgresql|include/postgresql include/postgresql/pgsql|g' -i configure

}


php-sapi_src_compile() {
	[ -x "/usr/sbin/sendmail" ] || die "You need a virtual/mta that provides /usr/sbin/sendmail!"

	[ -f "/proc/self/stat" ] || die "You need /proc mounted for configure to complete correctly!"

	use java && use !alpha && php-sapi_check_java_config

	if use berkdb; then
		einfo "Enabling NBDM"
		myconf="${myconf} --with-ndbm=/usr"
	 	#Hack to use db4
	 	if has_version '=sys-libs/db-4*' && grep -q -- '--with-db4' configure; then
	 		einfo "Enabling DB4"
	 		myconf="${myconf} --with-db4=/usr"
		elif has_version '=sys-libs/db-3*' && grep -q -- '--with-db3' configure; then
	 		einfo "Enabling DB3"
	 		myconf="${myconf} --with-db3=/usr"
		else
			einfo "Enabling DB2"
			myconf="${myconf} --with-db2=/usr"
	 	fi
	else
		einfo "Skipping DB2, DB3, DB4, NDBM support"
		myconf="${myconf} --without-db3 --without-db4 --without-db2 --without-ndbm"
	fi

	myconf="${myconf} `use_with crypt mcrypt /usr` `use_with crypt mhash /usr`"
	use x86 && myconf="${myconf} `use_with firebird interbase /opt/interbase`"
	myconf="${myconf} `use_with flash ming /usr`"
	use x86 && myconf="${myconf} `use_with flash swf /usr`"
	myconf="${myconf} `use_with freetds sybase /usr`"
	myconf="${myconf} `use_with gdbm gdbm /usr`"
	use x86 && myconf="${myconf} `use_with fdftk fdftk /opt/fdftk-6.0`"
	use !alpha && myconf="${myconf} `use_with java java ${JAVA_HOME}`"
	myconf="${myconf} `use_with mcal mcal /usr`"
	[ -n "${INFORMIXDIR}" ] && myconf="${myconf} `use_with informix informix ${INFORMIXDIR}`"
	[ -n "${ORACLE_HOME}" ] && myconf="${myconf} `use_with oci8 oci8 ${ORACLE_HOME}`"
	myconf="${myconf} `use_with odbc unixODBC /usr`"
	myconf="${myconf} `use_with postgres pgsql /usr`"
	myconf="${myconf} `use_with snmp snmp /usr`"
	use snmp && myconf="${myconf} --enable-ucd-snmp-hack"
	use X && myconf="${myconf} --with-xpm-dir=/usr/X11R6" LDFLAGS="${LDFLAGS} -L/usr/X11R6/lib"
	
	# This chunk is intended for png/tiff/jpg, as there are several things that need them, indepentandly!
	REQUIREPNG=
	REQUIREJPG=
	REQUIRETIFF=
	if use pdflib; then
		myconf="${myconf} --with-pdflib=/usr" 
		REQUIREPNG=1 REQUIREJPG=1 REQUIRETIFF=1
	else
		myconf="${myconf} --without-pdflib"
	fi

	if use gd-external; then
		myconf="${myconf} --with-gd=/usr"
		REQUIREPNG=1
		if has_version '>=media-libs/libgd-2.0.17'; then
			einfo "Fixing PHP for libgd function name changes"
			sed -i 's:gdFreeFontCache:gdFontCacheShutdown:' ${S}/ext/gd/gd.c
		fi
	elif use gd; then
		myconf="${myconf} --with-gd"
		myconf="${myconf} `use_enable truetype gd-native-ttf`" 
		REQUIREPNG=1 REQUIREJPG=1
	else
		myconf="${myconf} --without-gd"
	fi
	use png && REQUIREPNG=1
	use jpeg && REQUIREJPG=1
	use tiff && REQUIRETIFF=1
	if [ -n "${REQUIREPNG}" ]; then
		myconf="${myconf} --with-png=/usr --with-png-dir=/usr" 
	else
		myconf="${myconf} --without-png"
	fi
	if [ -n "${REQUIREJPG}" ]; then
		myconf="${myconf} --with-jpeg=/usr --with-jpeg-dir=/usr --enable-exif" 
	else
		myconf="${myconf} --without-jpeg" 
	fi
	if [ -n "${REQUIRETIFF}" ]; then
		myconf="${myconf} --with-tiff=/usr --with-tiff-dir=/usr" 
		LDFLAGS="${LDFLAGS} -ltiff"
	else
		myconf="${myconf} --without-tiff"
	fi

	if use mysql; then
		# check for mysql4.1 and mysql4.1 support in this php
		if [ -n "`mysql_config | grep '4.1'`" ] && grep -q -- '--with-mysqli' configure; then
			myconf="${myconf} --with-mysqli=/usr"
		else
			myconf="${myconf} --with-mysql=/usr"
			myconf="${myconf} --with-mysql-sock=`mysql_config --socket`"
		fi
	else
		myconf="${myconf} --without-mysql"
	fi

	if use truetype; then
		myconf="${myconf} --with-freetype-dir=/usr"
		myconf="${myconf} --with-ttf=/usr"
		myconf="${myconf} --with-t1lib=/usr"
	else
		myconf="${myconf} --without-ttf --without-t1lib"
	fi

	myconf="${myconf} `use_with nls gettext` `use_with qt qtdom /usr/qt/3`"
	myconf="${myconf} `use_with spell pspell /usr` `use_with ssl openssl /usr`"
	myconf="${myconf} `use_with imap imap /usr` `use_with ldap ldap /usr`"
	myconf="${myconf} `use_with xml2 dom /usr` `use_with xml2 dom-xslt /usr`"
	myconf="${myconf} `use_with xml2 dom-exslt /usr`"
	myconf="${myconf} `use_with kerberos kerberos /usr` `use_with pam`"
	myconf="${myconf} `use_enable memlimit memory-limit`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_with yaz`"
	if use curl; then
		myconf="${myconf} --with-curlwrappers --with-curl=/usr"
	else
		myconf="${myconf} --without-curl"
	fi

	#Waiting for somebody to want Cyrus support :-)
	#myconf="${myconf} `use_with cyrus`"

	# dbx AT LEAST one of mysql/odbc/postgres/oci8
	use mysql || use odbc || use postgres || use oci8 \
		&& myconf="${myconf} --enable-dbx" \
		|| myconf="${myconf} --disable-dbx"

	use imap && use ssl && \
	if [ -n "`strings ${ROOT}/usr/lib/c-client.a 2>/dev/null | grep ssl_onceonlyinit`" ]; then
		myconf="${myconf} --with-imap-ssl"
		einfo "Building IMAP with SSL support."
	else
		ewarn "USE=\"imap ssl\" specified but IMAP is built WITHOUT ssl support."
		ewarn "Skipping IMAP-SSL support."
	fi

	
	# These were previously optional, but are now included directly as PEAR needs them.
	# Zlib is needed for XML
	myconf="${myconf} --with-zlib=/usr --with-zlib-dir=/usr"
	LIBS="${LIBS} -lxmlparse -lxmltok"
	myconf="${myconf} --with-sablot=/usr"
	myconf="${myconf} --enable-xslt" 
	myconf="${myconf} --with-xslt-sablot" 
	myconf="${myconf} --with-xmlrpc"
	myconf="${myconf} --enable-wddx"
	myconf="${myconf} --with-xml"

	#Some extensions need mbstring statically built
	myconf="${myconf} --enable-mbstring=all --enable-mbregex"

	# Somebody might want safe mode, but it causes some problems, so I disable it by default
	#myconf="${myconf} --enable-safe-mode"

	# These are some things that we don't really need use flags for, we just
	# throw them in for functionality. Somebody could turn them off if their
	# heart so desired
	# DEPEND - app-arch/bzip2
	myconf="${myconf} --with-bz2=/usr"
	# DEPEND - sys-libs/cracklib
	myconf="${myconf} --with-crack=/usr"
	# DEPEND - nothing
	myconf="${myconf} --with-cdb"
	
	# No DEPENDancies
	myconf="${myconf} --enable-pcntl"
	myconf="${myconf} --enable-bcmath"
	myconf="${myconf} --enable-calendar"
	myconf="${myconf} --enable-dbase"
	myconf="${myconf} --enable-filepro"
	myconf="${myconf} --enable-ftp"
	myconf="${myconf} --with-mime-magic=/usr/share/misc/file/magic.mime"
	myconf="${myconf} --enable-sockets"
	myconf="${myconf} --enable-sysvsem --enable-sysvshm --enable-sysvipc"
	myconf="${myconf} --with-iconv"
	myconf="${myconf} --enable-shmop"
	myconf="${myconf} --enable-dio"
	myconf="${myconf} --enable-yp"

	# recode is NOT used as it conflicts with IMAP
	# iconv is better anyway

	# there is absolutely no reason to build ncurses/readline support on
	# anything other than the CLI sapi
	if [ "${PN}" = "php" ]; then
		myconf="${myconf} `use_with readline readline /usr`"
		# Readline and Ncurses are CLI PHP only
		# readline needs ncurses
		use ncurses || use readline \
			&& myconf="${myconf} --with-ncurses=/usr" \
			|| myconf="${myconf} --without-ncurses"
	else
		# both of these are not needed
		myconf="${myconf} --without-ncurses --without-readline"
	fi

	# Now actual base PHP settings
	myconf="${myconf} \
		--enable-inline-optimization \
		--enable-track-vars \
		--enable-trans-sid \
		--enable-versioning \
		--with-config-file-path=${PHPINIDIRECTORY}" 

	#fixes bug #24373 
	filter-flags "-D_FILE_OFFSET_BITS=64"
	filter-flags "-D_FILE_OFFSET_BITS=32"
	filter-flags "-D_LARGEFILE_SOURCE=1"
	filter-flags "-D_LARGEFILE_SOURCE"
	#fixes bug #14067
	# changed order to run it in reverse for bug #32022 and #12021 
	replace-flags "-march=k6-3" "-march=i586"
	replace-flags "-march=k6-2" "-march=i586"
	replace-flags "-march=k6" "-march=i586"

	if [ -z "${PHP_SKIP_CONFIGURE}" ]; then
	LDFLAGS="${LDFLAGS} -L/usr/lib" LIBS="${LIBS}" econf \
		${myconf} || die "bad ./configure, please include ${MY_P}/config.log in any bug reports."
	fi

	if [ -z "${PHP_SKIP_MAKE}" ]; then
		emake || die "compile problem"
	fi
}

php-sapi_src_install() {
	addpredict /usr/share/snmp/mibs/.index
	dodir /usr/bin
	dodir /usr/lib/php
	dodir /usr/include/php

	# parallel make breaks it
	# so no emake here
	make INSTALL_ROOT=${D} ${PHP_INSTALLTARGETS} || die

	# install a php-config for EACH instance of php
	# the PHP provider $PHP_PROVIDER_PKG one is the default
	mv ${D}/usr/bin/php-config ${D}/usr/bin/php-config.${PN}
	# these files are provided solely by the PHP provider ebuild
	php-sapi_is_providerbuild && dosym /usr/bin/php-config.${PN} /usr/bin/php-config
	php-sapi_is_providerbuild || rm ${D}/usr/bin/{phpize,phpextdist}

	# get the extension dir
	PHPEXTDIR="`${D}/usr/bin/php-config.${PN} --extension-dir`"
	
	for doc in LICENSE EXTENSIONS CREDITS INSTALL README.* TODO* NEWS; do
		[ -s "$doc" ] && dodoc $doc
	done

	#install scripts
	exeinto /usr/bin

	# Support for Java extension
	# 1. install php_java.jar file into ${EXT_DIR}
	# 2. edit the php.ini file ready for installation
	# - stuart@gentoo.org
	local phpinisrc=php.ini-dist
	einfo "Setting extension_dir in php.ini"
	sed -e "s|extension_dir .*$|extension_dir = ${PHPEXTDIR}|g" -i ${phpinisrc}

	if use java && use !alpha; then
		# we put these into /usr/lib so that they cannot conflict with
		# other versions of PHP (e.g. PHP 4 & PHP 5)
		insinto ${PHPEXTDIR}
		einfo "Installing JAR for PHP"
		doins ext/java/php_java.jar

		einfo "Installing Java test page"
		newins ext/java/except.php java-test.php

		JAVA_LIBRARY="`grep -- '-DJAVALIB' Makefile | sed -e 's,.\+-DJAVALIB=\"\([^"]*\)\".*$,\1,g;'| sort | uniq `"
		sed -e "s|;java.library .*$|java.library = ${JAVA_LIBRARY}|g" -i ${phpinisrc}
		sed -e "s|;java.class.path .*$|java.class.path = ${PHPEXTDIR}/php_java.jar|g" -i ${phpinisrc}
		sed -e "s|;java.library.path .*$|java.library.path = ${PHPEXTDIR}|g" -i ${phpinisrc}
		sed -e "s|;extension=php_java.dll.*$|extension = java.so|g" -i ${phpinisrc}
		dosym ${PHPEXTDIR}/java.so ${PHPEXTDIR}/libphp_java.so
	fi

	# A patch for PHP for security. PHP-CLI interface is exempt, as it cannot be
	# fed bad data from outside.
	if [ "${PHPSAPI}" != "cli" ]; then
		patch ${phpinisrc} <${DISTDIR}/php-4.3.2-fopen-url-secure.patch
	fi

	# A lot of ini file funkiness
	insinto ${PHPINIDIRECTORY}
	newins ${phpinisrc} ${PHPINIFILENAME}

	# 2004/03/28 - stuart@gentoo.org
	#
	# This is where we install header files that PHP itself doesn't install,
	# but which PECL packages depend on

	for x in ext/mbstring/libmbfl/mbfl/mbfilter.h ext/mbstring/libmbfl/mbfl/mbfl_defs.h ext/mbstring/libmbfl/mbfl/mbfl_consts.h ext/mbstring/libmbfl/mbfl/mbfl_allocators.h ext/mbstring/libmbfl/mbfl/mbfl_encoding.h ext/mbstring/libmbfl/mbfl/mbfl_language.h ext/mbstring/libmbfl/mbfl/mbfl_string.h ext/mbstring/libmbfl/mbfl/mbfl_convert.h ext/mbstring/libmbfl/mbfl/mbfl_ident.h ext/mbstring/libmbfl/mbfl/mbfl_memory_device.h; do
		my_headerdir="/usr/include/php/`dirname $x`"
		echo "$my_headerdir"
		if [ ! -d "${D}$my_headerdir" ]; then
			mkdir -p ${D}$my_headerdir
		fi
		cp $x ${D}/usr/include/php/$x
	done
}

php-sapi_pkg_preinst() {
	# obsolete
	einfo "Checking if we need to preserve a really old /etc/php4/php.ini file"
	if [ -e /etc/php4/php.ini ] && [ ! -L /etc/php4/php.ini ]; then
		ewarn "Old setup /etc/php4/php.ini file detected, moving to new location (${PHPINIDIRECTORY}/${PHPINIFILENAME})"
		mkdir -p ${PHPINIDIRECTORY}
		mv -f /etc/php4/php.ini ${PHPINIDIRECTORY}/${PHPINIFILENAME}
	else
		einfo "/etc/php4/php.ini doesn't exist or is a symlink, nothing wrong here"
	fi
}

php-sapi_pkg_postinst() {
	einfo "The INI file for this build is ${PHPINIDIRECTORY}/php.ini"
	if has_version 'dev-php/php-core'; then
		ewarn "The dev-php/php-core package is now obsolete. You should unmerge"
		ewarn "it, and re-merge >=dev-php/php-4.3.4-r2 afterwards to ensure"
		ewarn "your PHP installation is consistant."
	fi
}

php-sapi_securityupgrade() {
	if has_version "<${PF}"; then
		ewarn "This is a security upgrade for PHP!"
		ewarn "Please ensure that you apply any changes to the apache and PHP"
		ewarn "configutation files!"
	else
		einfo "This is a security upgrade for PHP!"
		einfo "However it is not critical for your machine"
	fi
}
