# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Update: Roman Weber <gentoo@gonzo.ch>
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-4.3.1-r2.ebuild,v 1.2 2003/04/24 10:18:20 robbat2 Exp $

inherit php eutils

IUSE="${IUSE} readline"

DESCRIPTION="PHP Shell Interpreter"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 ) "

RDEPEND="${RDEPEND}"

src_compile() {
	
	use readline && myconf="${myconf} --with-readline"

	
	myconf="${myconf} \
		--disable-cgi \
		--enable-cli \
		--enable-pcntl \
		--with-pear"
	
	php_src_compile

}


src_install() {
	installtargets="${installtargets} install-cli"
	php_src_install

	# php executable is located in ./sapi/cli/
	cp sapi/cli/php .
	exeinto /usr/bin
	doexe php

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
	# This is more correct information.
	einfo 
	einfo "This is a CLI only build."
	einfo "You can not use it on a webserver."
	einfo 
}
