# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/eaccelerator/eaccelerator-0.9.5.3-r1.ebuild,v 1.2 2010/09/26 13:49:26 olemarkus Exp $

PHP_EXT_NAME="eaccelerator"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

[[ -z "${EACCELERATOR_CACHEDIR}" ]] && EACCELERATOR_CACHEDIR="/var/cache/eaccelerator-php5/"

inherit php-ext-source-r1 eutils depend.apache autotools

KEYWORDS="~amd64 ~sparc ~x86"

DESCRIPTION="A PHP Accelerator & Encoder."
HOMEPAGE="http://www.eaccelerator.net/"
SRC_URI="http://bart.eaccelerator.net/source/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="contentcache debug disassembler inode session sharedmem"

DEPEND="!dev-php5/pecl-apc !dev-php5/xcache"
RDEPEND="${DEPEND}"

# Webserver user and group, here for Apache by default
HTTPD_USER="${HTTPD_USER:-apache}"
HTTPD_GROUP="${HTTPD_GROUP:-apache}"

need_php_by_category
want_apache

pkg_setup() {
	depend.apache_pkg_setup

	has_php

	require_php_sapi_from cgi apache2

	if use session ; then
		require_php_with_use session zlib
	else
		require_php_with_use zlib
	fi

	if ! use apache2 ; then
		if [[ ${HTTPD_USER} == "apache" ]] || [[ ${HTTPD_GROUP} == "apache" ]] ; then
			eerror "You did not enable apache2 USE flag, so you need to define"
			eerror "the user and group that will be used for ${PN} yourself."
			eerror
			eerror "This should (generally) match the user and group that your webserver uses, e.g.:"
			eerror "HTTPD_USER=\"lighttpd\" HTTPD_GROUP=\"lighttpd\" if using www-servers/lighttpd"
			eerror
			die "Either enable USE=\"apache2\" or re-emerge this with HTTPD_USER and HTTPD_GROUP set"
		else
			enewgroup ${HTTPD_GROUP}
			enewuser ${HTTPD_USER} -1 -1 /var/www ${HTTPD_GROUP}
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove the badly broken encoder, already done by upstream in SVN trunk
	# Also needed for security bug 277293.
	rm loader.c encoder.{php,c} doc/php/{loader,encoder}.php || die "Cannot remove encoder"
	epatch "${FILESDIR}/${PN}-remove-encoder.patch"

	eautoconf
	eautomake
	php-ext-source-r1_phpize
}

src_compile() {
	has_php

	my_conf="--enable-eaccelerator=shared --with-eaccelerator-userid=`id -u ${HTTPD_USER}`"

	use contentcache && my_conf="${my_conf} --with-eaccelerator-content-caching"
	use debug && my_conf="${my_conf} --with-eaccelerator-debug"
	use disassembler && my_conf="${my_conf} --with-eaccelerator-disassembler"
	! use inode && my_conf="${my_conf} --without-eaccelerator-use-inode"
	use session && my_conf="${my_conf} --with-eaccelerator-sessions"
	use sharedmem && my_conf="${my_conf} --with-eaccelerator-shared-memory"

	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install

	keepdir "${EACCELERATOR_CACHEDIR}"
	fowners ${HTTPD_USER}:${HTTPD_GROUP} "${EACCELERATOR_CACHEDIR}"
	fperms 750 "${EACCELERATOR_CACHEDIR}"

	insinto "/usr/share/${PN}-php5/"
	doins -r doc/php/
	dodoc-php AUTHORS ChangeLog COPYING NEWS README README.eLoader

	php-ext-base-r1_addtoinifiles "eaccelerator.shm_size" '"28"'
	php-ext-base-r1_addtoinifiles "eaccelerator.cache_dir" "\"${EACCELERATOR_CACHEDIR}\""
	php-ext-base-r1_addtoinifiles "eaccelerator.enable" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.optimizer" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.debug" '"0"'
	php-ext-base-r1_addtoinifiles ";eaccelerator.log_file" '"/var/log/eaccelerator_log"'
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
	php-ext-base-r1_addtoinifiles ";eaccelerator.allowed_admin_path" '"/path/where/admin/files/shall/be/allowed"'
}

pkg_postinst() {
	elog "Please see the files in ${ROOT}usr/share/${PN}-php5/ for some"
	elog "examples and informations on how to use the functions that"
	elog "eAccelerator adds to PHP."
}
