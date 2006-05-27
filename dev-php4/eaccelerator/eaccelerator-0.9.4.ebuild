# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/eaccelerator/eaccelerator-0.9.4.ebuild,v 1.2 2006/05/27 00:43:17 chtekk Exp $

PHP_EXT_NAME="eaccelerator"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="yes"

[ -z "${EACCELERATOR_CACHEDIR}" ] && EACCELERATOR_CACHEDIR="/var/cache/eaccelerator"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="A PHP Accelerator & Encoder."
HOMEPAGE="http://www.eaccelerator.net/"
SRC_URI="mirror://sourceforge/eaccelerator/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="inode session"

DEPEND="${DEPEND}
		!dev-php4/pecl-apc"

# this is a good example of why we need all web servers installed under a
# common 'www' user and group!
HTTPD_USER="apache"
HTTPD_GROUP="apache"

need_php_by_category

pkg_setup() {
	has_php

	require_php_sapi_from cgi apache apache2
	require_php_with_use zlib
}

src_unpack() {
	unpack ${A}

	cd "${S}"
}

src_compile() {
	has_php

	my_conf="--enable-eaccelerator=shared"

	if use !session; then
		my_conf="${my_conf} --without-eaccelerator-sessions"
	fi

	if use !inode; then
		my_conf="${my_conf} --without-eaccelerator-use-inode"
	fi

	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install

	keepdir "${EACCELERATOR_CACHEDIR}"
	fowners ${HTTPD_USER}:${HTTPD_GROUP} "${EACCELERATOR_CACHEDIR}"
	fperms 750 "${EACCELERATOR_CACHEDIR}"

	insinto "/usr/share/${PN}"
	doins encoder.php eaccelerator.php eaccelerator_password.php
	dodoc-php AUTHORS ChangeLog COPYING NEWS README README.eLoader

	php-ext-base-r1_addtoinifiles "eaccelerator.shm_size" '"64"'
	php-ext-base-r1_addtoinifiles "eaccelerator.cache_dir" "\"${EACCELERATOR_CACHEDIR}\""
	php-ext-base-r1_addtoinifiles "eaccelerator.enable" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.optimizer" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.debug" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.check_mtime" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.filter" '""'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_max" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_ttl" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_prune_period" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_only" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.compress" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.compress_level" '"9"'
	php-ext-base-r1_addtoinifiles "eaccelerator.keys" '"shm_and_disk"'
	php-ext-base-r1_addtoinifiles "eaccelerator.sessions" '"shm_and_disk"'
	php-ext-base-r1_addtoinifiles "eaccelerator.content" '"shm_and_disk"'
	php-ext-base-r1_addtoinifiles ";eaccelerator.admin.name" '"username"'
	php-ext-base-r1_addtoinifiles ";eaccelerator.admin.password" '"hashed_password"'
}

pkg_postinst() {
	# you only need to restart the webserver if you're using mod_php
	if built_with_use =${PHP_PKG} apache || built_with_use =${PHP_PKG} apache2 ; then
		einfo "You need to restart your webserver to activate eAccelerator."
		einfo
	fi

	# this web interface needs moving into a separate, webapp-config compatible
	# package!!
	einfo "A web interface is available to manage the eAccelerator cache."
	einfo "Copy /usr/share/eaccelerator/*.php to somewhere"
	einfo "where your web server can see it. See the documentation on how"
	einfo "to secure this web interface with authentication."
	einfo
	einfo "A PHP script encoder is available to encode your PHP scripts."
	einfo "The encoder is available as /usr/share/eaccelerator/encoder.php"
	einfo "The encoded file format is not yet considered stable."
}
