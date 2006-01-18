# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/php/php-4.4.1-r3.ebuild,v 1.3 2006/01/18 20:38:25 corsair Exp $

IUSE="cgi cli discard-path force-cgi-redirect"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ppc64 ~s390 ~sparc ~x86"

# NOTE: Portage doesn't support setting PROVIDE based on the USE flags
#		that have been enabled, so we have to PROVIDE everything for now
#		and hope for the best
#
#		This will be sorted out when GLEP 37 is implemented

PROVIDE="virtual/php virtual/httpd-php"

# php package settings
SLOT="4"
MY_PHP_P="php-${PV}"
PHP_PACKAGE=1

# php patch settings
HARDENEDPHP_PATCH="hardening-patch-${PV}-0.4.8-gentoo.patch.gz"
LIB64_PATCH="${PV}/php${PV}-multilib-search-path.patch"

inherit eutils php4_4-sapi apache-module

want_apache

DESCRIPTION="The PHP language runtime engine"

DEPEND="${DEPEND} app-admin/php-toolkit"
RDEPEND="${RDEPEND} app-admin/php-toolkit"

# PHP patchsets
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-patchset-${PV}-r1.tar.bz2"

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

	if useq fastbuild ; then
		ewarn
		ewarn "'fastbuild' attempts to build all SAPIs in a single pass."
		ewarn "This is an experimental feature, which may fail to compile"
		ewarn "and may produce PHP binaries which are broken."
		ewarn
		ewarn "Rebuild without 'fastbuild' and reproduce any bugs before filing"
		ewarn "any bugs in Gentoo's Bugzilla or bugs.php.net."
		ewarn
	fi

	php4_4-sapi_pkg_setup
}

src_unpack() {
	# custom src_unpack, used only for PHP ebuilds that need additional patches
	# normally the eclass src_unpack is used
	if [ "${PHP_PACKAGE}" == 1 ] ; then
		unpack ${A}
	fi

	cd "${S}"

	# fix PHP branding
	sed -e 's|^EXTRA_VERSION=""|EXTRA_VERSION="-pl3-gentoo"|g' -i configure.in

	# fix open_basedir bypass in CURL extension
	use curl && epatch "${WORKDIR}/${PV}/php${PV}-curl-open_basedir.patch"

	# fix header injection in mbstring extension
	use nls && epatch "${WORKDIR}/${PV}/php${PV}-mbstring-header_inj.patch"

	# fix safe_mode bypass in GD extension
	if use gd || use gd-external ; then
		epatch "${WORKDIR}/${PV}/php${PV}-gd-safe_mode.patch"
	fi

	# patch crash with mod_rewrite mentioned in bug #111032 and other Apache2
	# SAPI bugs fixed by upstream
	epatch "${WORKDIR}/${PV}/php${PV}-apache2sapi.patch"

	# fix for http://bugs.php.net/bug.php?id=35067
	epatch "${WORKDIR}/${PV}/php${PV}-current_key_by_reference.patch"

	# we call the eclass src_unpack, but don't want ${A} to be unpacked again
	PHP_PACKAGE=0
	php4_4-sapi_src_unpack
	PHP_PACKAGE=1
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
	if useq fastbuild ; then
		src_compile_fastbuild
	else
		src_compile_normal
	fi
}

src_compile_fastbuild() {
	php_determine_sapis

	build_cli=0
	build_cgi=0
	build_apache=0

	for x in ${PHPSAPIS} ; do
		case ${x} in
			cli)
				build_cli=1
				;;
			cgi)
				build_cgi=1
				;;
			apache*)
				build_apache=1
				;;
		esac
	done

	if [[ ${build_cli} = 1 ]] ; then
		my_conf="${my_conf} --enable-cli"
	else
		my_conf="${my_conf} --disable-cli"
	fi

	if [[ ${build_cgi} = 1 ]] ; then
		my_conf="${my_conf} --enable-cgi --enable-fastcgi"
		enable_extension_enable "discard-path" "discard-path" 0
		enable_extension_enable "force-cgi-redirect" "force-cgi-redirect" 0
	else
		my_conf="${my_conf} --disable-cgi"
	fi

	if [[ ${build_apache} = 1 ]] ; then
		my_conf="${my_conf} --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"
	fi

	# now we know what we are building, build it
	php4_4-sapi_src_compile

	# to keep the separate php.ini files for each SAPI, we change the
	# build-defs.h and recompile

	if [[ ${build_cli} = 1 ]] ; then
		einfo
		einfo "Building CLI SAPI"
		einfo

		sed -e 's|^#define PHP_CONFIG_FILE_PATH.*|#define PHP_CONFIG_FILE_PATH "/etc/php/cli-php4"|g;' -i main/build-defs.h
		sed -e 's|^#define PHP_CONFIG_FILE_SCAN_DIR.*|#define PHP_CONFIG_FILE_SCAN_DIR "/etc/php/cli-php4/ext-active"|g;' -i main/build-defs.h
		for x in main/main.o main/main.lo main/php_ini.o main/php_ini.lo ; do
			[[ -f ${x} ]] && rm -f ${x}
		done
		make sapi/cli/php || die "Unable to make CLI SAPI"
		cp sapi/cli/php php-cli || die "Unable to copy CLI SAPI"
	fi
	if [[ ${build_cgi} = 1 ]] ; then
		einfo
		einfo "Building CGI SAPI"
		einfo

		sed -e 's|^#define PHP_CONFIG_FILE_PATH.*|#define PHP_CONFIG_FILE_PATH "/etc/php/cgi-php4"|g;' -i main/build-defs.h
		sed -e 's|^#define PHP_CONFIG_FILE_SCAN_DIR.*|#define PHP_CONFIG_FILE_SCAN_DIR "/etc/php/cgi-php4/ext-active"|g;' -i main/build-defs.h
		for x in main/main.o main/main.lo main/php_ini.o main/php_ini.lo ; do
			[[ -f ${x} ]] && rm -f ${x}
		done
		make sapi/cgi/php || die "Unable to make CGI SAPI"
		cp sapi/cgi/php php-cgi || die "Unable to copy CGI SAPI"
	fi
	if [[ ${build_apache} = 1 ]] ; then
		einfo
		einfo "Building apache${USE_APACHE2} SAPI"
		einfo

		sed -e "s|^#define PHP_CONFIG_FILE_PATH.*|#define PHP_CONFIG_FILE_PATH \"/etc/php/apache${APACHE_VERSION}-php4\"|g;" -i main/build-defs.h
		sed -e "s|^#define PHP_CONFIG_FILE_SCAN_DIR.*|#define PHP_CONFIG_FILE_SCAN_DIR \"/etc/php/apache${APACHE_VERSION}-php4/ext-active\"|g;" -i main/build-defs.h
		for x in main/main.o main/main.lo main/php_ini.o main/php_ini.lo ; do
			[[ -f ${x} ]] && rm -f ${x}
		done
		make || die "Unable to build mod_php"
	fi
}

src_compile_normal() {
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
				php4_4-sapi_src_compile
				cp sapi/cli/php php-cli
				;;
			cgi)
				my_conf="${orig_conf} --disable-cli --enable-cgi --enable-fastcgi"
				enable_extension_enable "discard-path" "discard-path" 0
				enable_extension_enable "force-cgi-redirect" "force-cgi-redirect" 0
				php4_4-sapi_src_compile
				cp sapi/cgi/php php-cgi
				;;
			apache*)
				my_conf="${orig_conf} --disable-cli --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"
				php4_4-sapi_src_compile
				;;
		esac

		CLEAN_REQUIRED=1
	done
}

src_install() {
	php_determine_sapis

	destdir=/usr/$(get_libdir)/php4

	# let the eclass do the heavy lifting
	php4_4-sapi_src_install

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
				php4_4-sapi_install_ini
				;;
			cgi)
				einfo "Installing CGI SAPI"
				into ${destdir}
				dobin php-cgi || die "Unable to install ${x} sapi"
				php4_4-sapi_install_ini
				;;
			apache*)
				einfo "Installing apache${USE_APACHE2} SAPI"
				make INSTALL_ROOT="${D}" install-sapi || die "Unable to install ${x} SAPI"
				if [ -n "${USE_APACHE2}" ] ; then
					einfo "Installing Apache2 config for PHP (70_mod_php.conf)"
					insinto ${APACHE_MODULES_CONFDIR}
					doins "${FILESDIR}/4-any/apache-2.0/70_mod_php.conf"
				else
					einfo "Installing Apache config for PHP (70_mod_php.conf)"
					insinto ${APACHE_MODULES_CONFDIR}
					doins "${FILESDIR}/4-any/apache-1.3/70_mod_php.conf"
				fi
				php4_4-sapi_install_ini
				;;
		esac
	done

}

pkg_postinst()
{
	# Output some general info to the user
	if useq apache || useq apache2 ; then
		APACHE1_MOD_DEFINE="PHP4"
		APACHE1_MOD_CONF="70_mod_php"
		APACHE2_MOD_DEFINE="PHP4"
		APACHE2_MOD_CONF="70_mod_php"
		apache-module_pkg_postinst
	fi
	php4_4-sapi_pkg_postinst
}
