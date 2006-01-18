# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-java-bridge/php-java-bridge-2.0.8.ebuild,v 1.6 2006/01/18 20:23:58 corsair Exp $

PHP_EXT_NAME="java"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
DESCRIPTION="The PHP/Java bridge is a PHP module wich connects the PHP object system with the Java or ECMA 335 object system."
HOMEPAGE="http://php-java-bridge.sourceforge.net/"
SRC_URI="mirror://sourceforge/php-java-bridge/${PN}_${PV}.tar.bz2"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		>=dev-util/re2c-0.9.9
		dev-java/java-config
		=virtual/jdk-1.4*"

need_php_by_category

pkg_setup() {
	has_php

	# We need session support in PHP for this to compile
	require_php_with_use session
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Patch against 'zend_fetch_debug_backtrace' API change
	# only if PHP 5.0 is not used
	if ! has_version '=dev-lang/php-5.0*' ; then
		epatch "${FILESDIR}/zend_backtrace_api_change.diff"
	fi
}

src_compile() {
	has_php
	my_conf="--disable-servlet --with-java=`java-config --jdk-home`"
	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install
	insinto "${EXT_DIR}"
	doins modules/JavaBridge.jar
	doins modules/RunJavaBridge
	doins modules/libnatcJavaBridge.a
	doins modules/libnatcJavaBridge.so
	dodoc-php ChangeLog README README.GNU_JAVA PROTOCOL.TXT
}
