# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Update: Roman Weber <gentoo@gonzo.ch>
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.3.1-r1.ebuild,v 1.10 2003/04/24 18:16:09 robbat2 Exp $

IUSE="truetype postgres tiff libwww nls jpeg readline ssl oci8 mysql X gdbm curl imap xml2 xml cjk pdflib qt snmp crypt flash odbc ldap berkdb freetds firebird pam spell"

MY_P=php-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="PHP Shell Interpreter"
SRC_URI="http://us3.php.net/distributions/${MY_P}.tar.bz2"
HOMEPAGE="http://www.php.net/"
LICENSE="PHP"
SLOT="0"
PROVIDE="virtual/php"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

	# too many users not being able to compile with gmp support
	# - rphillips
	# >=dev-libs/gmp-3.1.1

DEPEND="
	X? ( virtual/x11 )
	qt? ( x11-libs/qt )
	nls? ( sys-devel/gettext )
	pam? ( >=sys-libs/pam-0.75 )
	png? ( >=media-libs/libpng-1.2.5 )
	xml? ( >=net-libs/libwww-5.3.2
		>=app-text/sablotron-0.95-r1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )
	curl? ( >=net-ftp/curl-7.9.0 )
	java? ( virtual/jdk )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	imap? ( >=net-mail/uw-imap-2001a-r1 )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	ldap? ( >=net-nds/openldap-1.2.11 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.5 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	xml2? ( dev-libs/libxml2 )
	crypt? ( >=dev-libs/libmcrypt-2.4
		>=app-crypt/mhash-0.8 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	flash? ( media-libs/libswf
		>=media-libs/ming-0.2a )
	spell? ( app-text/aspell )
	berkdb? ( >=sys-libs/db-3 )
	libwww? ( >=net-libs/libwww-5.3.2 )
	freetds? ( >=dev-db/freetds-0.53 )
	pdflib? ( >=media-libs/pdflib-4.0.1-r2 )
	truetype? ( ~media-libs/freetype-1.3.1
		>=media-libs/t1lib-1.3.1 )
	firebird? ( >=dev-db/firebird-1.0 )
	postgres? ( >=dev-db/postgresql-7.1 )
	readline? ( >=sys-libs/ncurses-5.1
		>=sys-libs/readline-4.1 )"

#Removed
#java? ( virtual/jdk )

RDEPEND="
	xml? ( >=app-text/sablotron-0.95-r1 >=net-libs/libwww-5.3.2 )
	qt? ( >=x11-libs/qt-2.3.0 )
	java? ( virtual/jdk )"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}

	# Configure Patch for wired uname -a
	mv configure configure.old
	cat configure.old | sed "s/PHP_UNAME=\`uname -a\`/PHP_UNAME=\`uname -s -n -r -v\`/g" > configure
	chmod 755 configure

	# fix PEAR installer
	cp pear/PEAR/Registry.php pear/PEAR/Registry.old
	sed "s:\$pear_install_dir\.:\'$D/usr/lib/php/\' . :g" pear/PEAR/Registry.old > pear/PEAR/Registry.php

	# if [ "`use java`" ] ; then

	#	cp configure configure.orig
	#	cat configure.orig | \
	#		sed -e 's/LIBS="-lttf $LIBS"/LIBS="-lttf $LIBS"/' \
	#		> configure

	#	cp ext/gd/gd.c ext/gd/gd.c.orig
	#	cat ext/gd/gd.c.orig | \
	#		sed -e "s/typedef FILE gdIOCtx;//" \
	#		> ext/gd/gd.c
	#	if [ "$JAVAC" ];
	#	then
	#             cp ext/java/Makefile.in ext/java/Makefile.in.orig
	#              cat ext/java/Makefile.in.orig | \
	#                      sed -e "s/^\tjavac/\t\$(JAVAC)/" \
	#                      > ext/java/Makefile.in
	#	fi
	# fi
}

src_compile() {

	local myconf

	use readline && myconf="${myconf} --with-readline"
	use nls && myconf="${myconf} --with-gettext" || myconf="${myconf} --without-gettext"
	use ssl && myconf="${myconf} --with-openssl"
	use cjk && myconf="${myconf} --enable-mbstring"
	use curl && myconf="${myconf} --with-curl"
	use snmp && myconf="${myconf} --with-snmp --enable-ucd-snmp-hack"
	use gdbm && myconf="${myconf} --with-gdbm=/usr"
	use berkdb && myconf="${myconf} --with-db3=/usr"
	use mysql && myconf="${myconf} --with-mysql=/usr" || myconf="${myconf} --without-mysql"
	use freetds && myconf="${myconf} --with-sybase=/usr"
	use postgres && myconf="${myconf} --with-pgsql=/usr"
	use odbc && myconf="${myconf} --with-unixODBC=/usr"
	use ldap &&  myconf="${myconf} --with-ldap"
	use firebird && myconf="${myconf} --with-interbase=/opt/interbase"
	use truetype && myconf="${myconf} --with-ttf --with-t1lib"
	use pdflib && myconf="${myconf} --enable-pdflib=/usr"
	use jpeg && myconf="${myconf} --with-jpeg-dir=/usr/lib" || myconf="${myconf} --without-jpeg"
	use tiff && myconf="${myconf} --with-tiff-dir=/usr" || myconf="${myconf} --without-tiff"
	use png || myconf="${myconf} --without-png"
	use spell && myconf="${myconf} --with-pspell"

	# optional support for oracle oci8 
	if [ "`use oci8`" ] ; then 
			if [ "$ORACLE_HOME" ] ; then 
					myconf="${myconf} --with-oci8=${ORACLE_HOME}" 
			fi 
	fi

	use qt && myconf="${myconf} --with-qtdom" 

	if [ "`use imap`" ] ; then
		if [ "`use ssl`" ] && [ "`strings ${ROOT}/usr/lib/c-client.a \
					| grep ssl_onceonlyinit`" ] ; then
			echo "Compiling imap with SSL support"
			myconf="${myconf} --with-imap --with-imap-ssl"
		else
			echo "Compiling imap without SSL support"
			myconf="${myconf} --with-imap"
		fi
	fi
	use libwww && myconf="${myconf} --with-xml" || myconf="${myconf} --disable-xml"
	use flash && myconf="${myconf} --with-swf=/usr --with-ming=/usr"

	if [ "`use xml`" ] ; then
		export LIBS="-lxmlparse -lxmltok"
		myconf="${myconf} --enable-xslt" 
		myconf="${myconf} --with-xslt-sablot=/usr" 
		myconf="${myconf} --with-xmlrpc"
	fi

	use xml2 && myconf="${myconf} --with-dom"
	use crypt && myconf="${myconf} --enable-mcrypt=/usr --with-mhash"
	use java && myconf="${myconf} --with-java=${JAVA_HOME}"

	LDFLAGS="$LDFLAGS -ltiff -ljpeg"

	if [ "`use X`" ] ; then
		myconf="${myconf} --with-xpm-dir=/usr/X11R6"
		LDFLAGS="$LDFLAGS -L/usr/X11R6/lib"
	fi
		# --with-gmp \

	econf \
		--with-bz2 \
		--enable-ftp \
		--enable-dbase \
		--with-zlib=yes \
		--enable-bcmath \
		--enable-sysvsem \
		--enable-sysvshm \
		--with-gd \
		--enable-sockets \
		--enable-cli \
		--disable-cgi \
		--enable-calendar \
		--enable-trans-sid \
		--enable-versioning \
		--enable-track-vars \
		--enable-inline-optimization \
		--with-config-file-path=/etc/php4 \
		--with-pear \
		--enable-pcntl \
		${myconf} || die "bad ./configure"

	make || die "compile problem"
}


src_install() {
	addwrite /usr/share/snmp/mibs/.index

	make INSTALL_ROOT=${D} install-cli install-pear install-headers install-programs install-modules install-build || die

	dodoc CODING_STANDARDS LICENSE EXTENSIONS 
	dodoc RELEASE_PROCESS README.* TODO NEWS
	dodoc ChangeLog* *.txt

	# php executable is located in ./sapi/cli/
	cp sapi/cli/php .
	exeinto /usr/bin
	doexe php

	#install scripts
	exeinto /usr/bin
	doexe ${S}/pear/scripts/phpize
	doexe ${S}/pear/scripts/php-config
	doexe ${S}/pear/scripts/phpextdist

	# Support for Java extension
	#
	# 1. install php_java.jar file into /etc/php4/lib directory
	# 2. edit the php.ini file ready for installation
	#
	# - stuart@gnqs.org

	if [ "`use java`" ] ; then

		# we put these into /usr/lib so that they cannot conflict
		# with other versions of PHP

		insinto /usr/lib/php/extensions/no-debug-non-zts-20020429
		doins ext/java/php_java.jar

		cp ext/java/except.php java-test.php
		doins java-test.php

		JAVA_LIBRARY="`grep -- '-DJAVALIB' Makefile | sed -e 's/.\+-DJAVALIB=\"\([^"]*\)\".*$/\1/g;'`"
		cat php.ini-dist | sed -e "s|;java.library .*$|java.library = $JAVA_LIBRARY|g;" > php.ini-1
		cat php.ini-1 | sed -e "s|;java.class.path .*$|java.class.path = /etc/php4/lib/php_java.jar|g;" > php.ini-2
		cat php.ini-2 | sed -e "s|extension_dir .*$|extension_dir = /etc/php4/lib|g;" > php.ini-3
		cat php.ini-3 | sed -e "s|;extension=php_java.dll.*$|extension = java.so|g;" > php.ini-4
		cat php.ini-4 | sed -e "s|;java.library.path .*$|java.library.path = /etc/php4/lib/|g;" > php.ini-5

		mv php.ini-5 php.ini
	else
		mv php.ini-dist php.ini
	fi

    insinto /etc/php4
	doins php.ini

	if [ "`use java`" ]; then
		# I can't find a way to make these symlinks using dosym
		# SLH - 20030211

		( cd ${D}/usr/lib/php/extensions/no-debug-non-zts-20020429 ; ln -snf java.so libphp_java.so )
		( cd ${D}/etc/php4 ; ln -snf ../../usr/lib/php/extensions/no-debug-non-zts-20020429 lib )
	fi

}

pkg_postinst() {
	# This fixes the permission from world writeable to the correct one.
	# - novell@kiruna.se
	chmod 755 /usr/bin/pear

	# This is more correct information.
	einfo 
	einfo "This is a CLI only build."
	einfo "You can not use it on a webserver."
	einfo 
}
