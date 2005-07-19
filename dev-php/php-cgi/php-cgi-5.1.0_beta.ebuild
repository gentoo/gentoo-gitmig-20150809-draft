# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cgi/php-cgi-5.1.0_beta.ebuild,v 1.1 2005/07/19 13:25:04 stuart Exp $

PHPSAPI="cgi"
MY_PHP_P="php-5.1.0b3"
PHP_S="${WORKDIR}/${MY_PHP_P}"
PHP_PACKAGE=1

inherit php5-sapi-r3 eutils

DESCRIPTION="PHP Shell Interpreter"
LICENSE="PHP"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
DEPEND=""
PROVIDE="virtual/httpd-php"
SLOT="0"
IUSE="fastcgi force-cgi-redirect"

PHP_INSTALLTARGETS="install"

src_unpack() {
	php5-sapi-r3_src_unpack

	###########################################################################
	# DO NOT ADD YOUR PATCHES HERE
	#
	# Please add your patches into the eclass, where they belong!
	#
	# Thanks,
	# Stu
	###########################################################################
}

src_compile () {
	my_conf="${my_conf} --enable-cgi --disable-cli"

	if use fastcgi; then
		my_conf="${my_conf} --enable-fastcgi"
	fi

	if use force-cgi-redirect; then
		my_conf="${my_conf} --enable-force-cgi-redirect"
	fi

	php5-sapi-r3_src_compile
}

src_install () {
	php5-sapi-r3_src_install

	# PHP's makefile calls the cgi bin 'php'
	# we need to rename it by hand
	mv ${D}/usr/bin/php ${D}/usr/bin/php-cgi
}
