# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php/php-5.0.4.ebuild,v 1.6 2005/09/09 17:29:01 swegener Exp $

IUSE="cgi cli discard-path force-cgi-redirect"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

# NOTE: Portage doesn't support setting PROVIDE based on the USE flags
#		that have been enabled, so we have to PROVIDE everything for now
#		and hope for the best
#
#		This will be sorted out when GLEP 37 is implemented

PROVIDE="virtual/php virtual/httpd-php"

SLOT="5"
PHPSAPI_ALLOWED="cli cgi apache apache2"
MY_PHP_P="php-${PV}"
PHP_S="${WORKDIR}/${MY_PHP_P}"
PHP_PACKAGE=1

inherit eutils php5_0-sapi apache-module

want_apache

DESCRIPTION="The PHP language runtime engine"

DEPEND="${DEPEND} app-admin/eselect-php"
RDEPEND="${RDEPEND} app-admin/eselect-php"

pkg_setup() {
	# make sure the user has specified a SAPI
	einfo "Determining SAPI(s) to build"
	confutils_require_any "  Enabled  SAPI:" "  Disabled SAPI:" cli cgi apache apache2

	if useq apache || useq apache2 ; then
		if [ "${APACHE_VERSION}" != "0" ] ; then
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

	if useq cli ; then
		PHPSAPIS="${PHPSAPIS} cli"
	fi

	if useq cgi ; then
		PHPSAPIS="${PHPSAPIS} cgi"
	fi

	# note - we can only build one apache sapi for now
	# note - apache SAPI comes after the simpler cli/cgi sapis

	if useq apache || useq apache2 ; then
		if [ "${APACHE_VERSION}" != "0" ]; then
			PHPSAPIS="${PHPSAPIS} apache${APACHE_VERSION}"
		fi
	fi
}

src_compile() {
	php_determine_sapis

	CLEAN_REQUIRED=0

	for x in ${PHPSAPIS} ; do
		if [ "${CLEAN_REQUIRED}" = 1 ]; then
			make clean
			# echo > /dev/null
		fi

		PHPSAPI=${x}
		case ${x} in
			cli)
				my_conf="--enable-cli --disable-cgi"
				php5_0-sapi_src_compile
				cp sapi/cli/php php-cli
				;;
			cgi)
				my_conf="${orig_conf} --disable-cli --enable-cgi --enable-fastcgi"
				enable_extension_enable "discard-path" "discard-path" 0
				enable_extension_enable "force-cgi-redirect" "force-cgi-redirect" 0
				php5_0-sapi_src_compile
				cp sapi/cgi/php php-cgi
				;;
			apache*)
				my_conf="${orig_conf} --disable-cli --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"
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
				make INSTALL_ROOT=${D} install-sapi || die "Unable to install ${x} SAPI"
				if [ -n "${USE_APACHE2}" ] ; then
					einfo "Installing Apache2 config for PHP5 (70_mod_php5.conf)"
					insinto ${APACHE_MODULES_CONFDIR}
					doins "${FILESDIR}/5.1.0/apache-2.0/70_mod_php5.conf"
				else
					einfo "Installing Apache config for PHP5 (70_mod_php5.conf)"
					insinto ${APACHE_MODULES_CONFDIR}
					doins "${FILESDIR}/5.1.0/apache-1.3/70_mod_php5.conf"
				fi
				php5_0-sapi_install_ini
				;;
		esac
	done
}

pkg_postinst()
{
	# Output some general info to the user
	if useq apache || useq apache2 ; then
		APACHE1_MOD_DEFINE="PHP5"
		APACHE1_MOD_CONF="70_mod_php5.conf"
		APACHE2_MOD_DEFINE="PHP5"
		APACHE2_MOD_CONF="70_mod_php5.conf"
		apache-module_pkg_postinst
	fi
	php5_0-sapi_pkg_postinst
}
