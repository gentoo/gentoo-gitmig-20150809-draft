# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/mod_php/mod_php-5.1.0_beta.ebuild,v 1.2 2005/06/19 08:58:56 stuart Exp $

IUSE="${IUSE} apache2"

# this duplicates the code from depend.apache.eclass, but it's the
# only way to do this here

if useq apache2 ; then
	APACHE_VERSION=2
else
	APACHE_VERSION=1
fi

KEYWORDS="~x86 ~amd64 ~ppc64"
PROVIDE="virtual/httpd-php"

SLOT="${APACHE_VERSION}"

PHPSAPI="apache${APACHE_VERSION}"
MY_PVR="5.1.0b1"
MY_PHP_P="php-${MY_PVR}"
PHP_S="${WORKDIR}/php-${MY_PVR}"
PHP_PACKAGE=1

# BIG FAT WARNING!
# the php eclass requires the PHPSAPI setting!
inherit eutils php5-sapi-r3 apache-module

need_apache

DESCRIPTION="Apache module for PHP 5"

pkg_setup() {

	# the list of safe MPM's may need revising
	if ! useq threads ; then
		APACHE2_SAFE_MPMS="prefork"
	else
		APACHE2_SAFE_MPMS="event metuxmpm peruser worker threadpool"
	fi

	apache-module_pkg_setup
	php5-sapi-r3_pkg_setup
}

src_unpack() {
	php5-sapi-r3_src_unpack

	# if we're not using threads, we need to force them to be switched
	# off by patching php's configure script
	cd ${S}
	if ! useq threads ; then
		epatch ${FILESDIR}/php5-prefork.patch || die "Unable to patch for prefork support"
		einfo "Rebuilding configure script"
		WANT_AUTOCONF=2.5 \
		autoconf -W no-cross || die "Unable to regenerate configure script"
	fi

	#########################################################################
	# DO NOT ADD PATCHES HERE UNLESS THEY ARE UNIQUE TO MOD_PHP
	#
	# Please add your patches to the eclass, where they belong ;-)
	#
	# Best regards,
	# Stu
	#########################################################################
}

src_compile() {
	if [ "${APACHE_VERSION}" = "2" ]; then
			if useq threads ; then
				my_conf="${my_conf} --enable-experimental-zts"
				ewarn "Enabling ZTS for Apache2 MPM"
			fi
	fi

	my_conf="${my_conf} --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"

	php5-sapi-r3_src_compile
}

src_install() {
	PHP_INSTALLTARGETS="install"
	php5-sapi-r3_src_install

	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Installing a Apache2 config for PHP (70_mod_php5.conf)"
		insinto ${APACHE_MODULES_CONFDIR}
		doins "${FILESDIR}/5.0.4/70_mod_php5.conf"
	else
		einfo "Installing a Apache config for PHP (mod_php5.conf)"
		insinto ${APACHE_MODULES_CONFDIR}
		doins ${FILESDIR}/mod_php5.conf
	fi
}
