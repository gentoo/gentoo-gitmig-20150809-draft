# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/eaccelerator/eaccelerator-0.9.3-r1.ebuild,v 1.5 2005/10/11 04:48:31 sebastian Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_NAME="eaccelerator"
PHP_EXT_INI="yes"

[ -z "${EACCELERATOR_CACHEDIR}" ] && EACCELERATOR_CACHEDIR=/var/cache/eaccelerator

inherit php-ext-source

DESCRIPTION="A PHP Accelerator & Encoder."
HOMEPAGE="http://www.eaccelerator.net/"
SRC_URI="mirror://sourceforge/eaccelerator/${P}.tar.gz"
IUSE="inode session"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="${DEPEND}
		=virtual/httpd-php-4*
		!dev-php/ioncube_loaders
		!dev-php/PECL-apc"

# this is a good example of why we need all web servers installed under a
# common 'www' user and group!
HTTPD_USER=apache
HTTPD_GROUP=apache

src_compile() {
	my_conf="--enable-eaccelerator=shared"

	if use !session; then
		my_conf="${my_conf} --without-eaccelerator-sessions"
	fi

	if use !inode; then
		my_conf="${my_conf} --without-eaccelerator-use-inode"
	fi

	export WANT_AUTOMAKE=1.6
	php-ext-source_src_compile
}

src_install() {
	php-ext-source_src_install

	keepdir ${EACCELERATOR_CACHEDIR}
	fowners ${HTTPD_USER}:${HTTPD_GROUP} "${EACCELERATOR_CACHEDIR}"
	fperms 750 "${EACCELERATOR_CACHEDIR}"

	insinto /usr/share/${PN}
	doins encoder.php eaccelerator.php eaccelerator_password.php
	dodoc AUTHORS ChangeLog COPYING NEWS README README.eLoader

	php-ext-base_addtoinifiles "eaccelerator.shm_size" '"64"'
	php-ext-base_addtoinifiles "eaccelerator.cache_dir" "\"${EACCELERATOR_CACHEDIR}\""
	php-ext-base_addtoinifiles "eaccelerator.enable" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.optimizer" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.debug" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.check_mtime" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.filter" '""'
	php-ext-base_addtoinifiles "eaccelerator.shm_max" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.shm_ttl" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.shm_prune_period" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.shm_only" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.compress" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.compress_level" '"9"'
	php-ext-base_addtoinifiles "eaccelerator.keys" '"shm_and_disk"'
	php-ext-base_addtoinifiles "eaccelerator.sessions" '"shm_and_disk"'
	php-ext-base_addtoinifiles "eaccelerator.content" '"shm_and_disk"'
	php-ext-base_addtoinifiles ";eaccelerator.admin.name" '"username"'
	php-ext-base_addtoinifiles ";eaccelerator.admin.password" '"hashed_password"'
}

pkg_postinst() {
	# you only need to restart the webserver if you're using mod_php
	if has_version "dev-php/mod_php" ; then
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
