# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php/php-5.0.5-r5.ebuild,v 1.14 2006/04/20 12:35:09 chtekk Exp $

IUSE="cgi cli discard-path force-cgi-redirect"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

# NOTE: Portage doesn't support setting PROVIDE based on the USE flags
#		that have been enabled, so we have to PROVIDE everything for now
#		and hope for the best
PROVIDE="virtual/php virtual/httpd-php"

# php package settings
SLOT="5"
MY_PHP_PV="${PV}"
MY_PHP_P="php-${MY_PHP_PV}"
PHP_PACKAGE=1

# php patch settings
PHP_PATCHSET_REV="2"
HARDENEDPHP_PATCH="hardening-patch-${MY_PHP_PV}-0.4.8-gentoo.patch.gz"
MULTILIB_PATCH="${MY_PHP_PV}/opt/php${MY_PHP_PV}-multilib-search-path.patch"

inherit php5_0-sapi apache-module

want_apache

DESCRIPTION="The PHP language runtime engine."

DEPEND="${DEPEND} app-admin/php-toolkit"
RDEPEND="${RDEPEND} app-admin/php-toolkit"

# PHP patchsets
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-patchset-${MY_PHP_PV}-r${PHP_PATCHSET_REV}.tar.bz2"

# Hardened-PHP patch
[[ -n "${HARDENEDPHP_PATCH}" ]] && SRC_URI="${SRC_URI} hardenedphp? ( http://gentoo.longitekk.com/${HARDENEDPHP_PATCH} )"

pkg_setup() {
	PHPCONFUTILS_AUTO_USE=""

	# make sure the user has specified a SAPI
	einfo "Determining SAPI(s) to build"
	phpconfutils_require_any "  Enabled  SAPI:" "  Disabled SAPI:" cli cgi apache apache2

	if useq apache2 ; then
		if [[ "${APACHE_VERSION}" != "0" ]] ; then
			if ! useq threads ; then
				APACHE2_SAFE_MPMS="peruser prefork"
			else
				APACHE2_SAFE_MPMS="event leader metuxmpm perchild threadpool worker"
			fi

			ewarn
			ewarn "If this package fails with a fatal error about Apache2 not having"
			ewarn "been compiled with a compatible MPM, this is normally because you"
			ewarn "need to toggle the 'threads' USE flag."
			ewarn
			ewarn "If 'threads' is off, try switching it on."
			ewarn "If 'threads' is on, try switching it off."
			ewarn

			apache-module_pkg_setup
		fi
	fi

	php5_0-sapi_pkg_setup
}

php_determine_sapis() {
	# holds the list of sapis that we want to build
	PHPSAPIS=

	if useq cli || phpconfutils_usecheck cli ; then
		PHPSAPIS="${PHPSAPIS} cli"
	fi

	if useq cgi ; then
		PHPSAPIS="${PHPSAPIS} cgi"
	fi

	# note - we can only build one apache sapi for now
	# note - apache SAPI comes after the simpler cli/cgi sapis
	if useq apache || useq apache2 ; then
		if [[ "${APACHE_VERSION}" != "0" ]] ; then
			PHPSAPIS="${PHPSAPIS} apache${APACHE_VERSION}"
		fi
	fi
}

src_compile() {
	php_determine_sapis

	CLEAN_REQUIRED=0

	for x in ${PHPSAPIS} ; do
		if [[ "${CLEAN_REQUIRED}" = 1 ]] ; then
			make clean
		fi

		PHPSAPI=${x}

		case ${x} in
			cli)
				my_conf="--enable-cli --disable-cgi"
				php5_0-sapi_src_compile
				cp sapi/cli/php php-cli
				;;
			cgi)
				my_conf="--disable-cli --enable-cgi --enable-fastcgi"
				phpconfutils_extension_enable "discard-path" "discard-path" 0
				phpconfutils_extension_enable "force-cgi-redirect" "force-cgi-redirect" 0
				php5_0-sapi_src_compile
				cp sapi/cgi/php php-cgi
				;;
			apache*)
				my_conf="--disable-cli --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"
				php5_0-sapi_src_compile
				;;
		esac

		CLEAN_REQUIRED=1
	done
}

src_install() {
	php_determine_sapis

	destdir=/usr/$(get_libdir)/php5

	# let the eclass do the heavy lifting
	php5_0-sapi_src_install

	einfo
	einfo "Installing SAPI(s) ${PHPSAPIS}"
	einfo

	for x in ${PHPSAPIS} ; do
		PHPSAPI=${x}
		case ${x} in
			cli)
				einfo "Installing CLI SAPI"
				into ${destdir}
				newbin php-cli php || die "Unable to install ${x} sapi"
				php5_0-sapi_install_ini
				;;
			cgi)
				einfo "Installing CGI SAPI"
				into ${destdir}
				dobin php-cgi || die "Unable to install ${x} sapi"
				php5_0-sapi_install_ini
				;;
			apache*)
				einfo "Installing apache${USE_APACHE2} SAPI"
				make INSTALL_ROOT="${D}" install-sapi || die "Unable to install ${x} SAPI"
				if [[ -n "${USE_APACHE2}" ]] ; then
					einfo "Installing Apache2 config file for PHP5 (70_mod_php5.conf)"
					insinto ${APACHE_MODULES_CONFDIR}
					newins "${FILESDIR}/70_mod_php5.conf-apache2" "70_mod_php5.conf"
				else
					einfo "Installing Apache config file for PHP5 (70_mod_php5.conf)"
					insinto ${APACHE_MODULES_CONFDIR}
					newins "${FILESDIR}/70_mod_php5.conf-apache1" "70_mod_php5.conf"
				fi
				php5_0-sapi_install_ini
				;;
		esac
	done
}

pkg_postinst() {
	# Output some general info to the user
	if useq apache || useq apache2 ; then
		APACHE1_MOD_DEFINE="PHP5"
		APACHE1_MOD_CONF="70_mod_php5"
		APACHE2_MOD_DEFINE="PHP5"
		APACHE2_MOD_CONF="70_mod_php5"
		apache-module_pkg_postinst
	fi
	php5_0-sapi_pkg_postinst
}
