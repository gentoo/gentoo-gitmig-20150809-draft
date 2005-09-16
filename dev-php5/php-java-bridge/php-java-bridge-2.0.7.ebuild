# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/php-java-bridge/php-java-bridge-2.0.7.ebuild,v 1.3 2005/09/16 23:26:13 trapni Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_NAME="java"
PHP_EXT_INI="yes"

inherit php-ext-source-r1

SRC_URI="mirror://sourceforge/php-java-bridge/${PN}_${PV}.tar.bz2"
HOMEPAGE="http://php-java-bridge.sourceforge.net/"

DESCRIPTION="The PHP/Java bridge is a PHP module wich connects the PHP object system with the Java or ECMA 335 object system."
LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="${DEPEND}
		>=dev-util/re2c-0.9.9
		dev-java/java-config
		=virtual/jdk-1.4*"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use java-external
}

src_compile() {
	has_php
	export WANT_AUTOCONF=2.5
	my_conf="--disable-servlet --with-java=`java-config --jdk-home`"
	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install
	insinto ${EXT_DIR}
	doins modules/JavaBridge.jar
	doins modules/RunJavaBridge
	doins modules/libnatcJavaBridge.a
	doins modules/libnatcJavaBridge.so
	dodoc ChangeLog README README.GNU_JAVA PROTOCOL.TXT
}
