# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/depend.php.eclass,v 1.8 2006/01/01 01:14:59 swegener Exp $
#
# ========================================================================
#
# depend.php.eclass
#		functions to allow ebuilds to depend on php4 and/or php5
#
# Author:	Stuart Herbert
#			<stuart@gentoo.org>
#
# Author:	Luca Longinotti
#			<chtekk@gentoo.org>
#
# Maintained by the PHP Herd <php-bugs@gentoo.org>
#
# ========================================================================

inherit eutils

# PHP4-only depend functions
need_php4_cli()
{
	DEPEND="${DEPEND} =virtual/php-4*"
	RDEPEND="${RDEPEND} =virtual/php-4*"
	PHP_VERSION=4
}

need_php4_httpd()
{
	DEPEND="${DEPEND} =virtual/httpd-php-4*"
	RDEPEND="${RDEPEND} =virtual/httpd-php-4*"
	PHP_VERSION=4
}

need_php4()
{
	DEPEND="${DEPEND} =dev-lang/php-4*"
	RDEPEND="${RDEPEND} =dev-lang/php-4*"
	PHP_VERSION=4
	PHP_SHARED_CAT="php4"
}

# common settings go in here
uses_php4()
{
	# cache this
	libdir=$(get_libdir)

	PHPIZE="/usr/${libdir}/php4/bin/phpize"
	PHPCONFIG="/usr/${libdir}/php4/bin/php-config"
	PHPCLI="/usr/${libdir}/php4/bin/php"
	PHPCGI="/usr/${libdir}/php4/bin/php-cgi"
	PHP_PKG="`best_version =dev-lang/php-4*`"
	PHPPREFIX="/usr/${libdir}/php4"

	einfo
	einfo "Using ${PHP_PKG}"
	einfo
}

# PHP5-only depend functions
need_php5_cli()
{
	DEPEND="${DEPEND} =virtual/php-5*"
	RDEPEND="${RDEPEND} =virtual/php-5*"
	PHP_VERSION=5
}

need_php5_httpd()
{
	DEPEND="${DEPEND} =virtual/httpd-php-5*"
	RDEPEND="${RDEPEND} =virtual/httpd-php-5*"
	PHP_VERSION=5
}

need_php5()
{
	DEPEND="${DEPEND} =dev-lang/php-5*"
	RDEPEND="${RDEPEND} =dev-lang/php-5*"
	PHP_VERSION=5
	PHP_SHARED_CAT="php5"
}

# common settings go in here
uses_php5()
{
	# cache this
	libdir=$(get_libdir)

	PHPIZE="/usr/${libdir}/php5/bin/phpize"
	PHPCONFIG="/usr/${libdir}/php5/bin/php-config"
	PHPCLI="/usr/${libdir}/php5/bin/php"
	PHPCGI="/usr/${libdir}/php5/bin/php-cgi"
	PHP_PKG="`best_version =dev-lang/php-5*`"
	PHPPREFIX="/usr/${libdir}/php5"

	einfo
	einfo "Using ${PHP_PKG}"
	einfo
}

# general PHP depend functions
need_php_cli()
{
	DEPEND="${DEPEND} virtual/php"
	RDEPEND="${RDEPEND} virtual/php"
}

need_php_httpd()
{
	DEPEND="${DEPEND} virtual/httpd-php"
	RDEPEND="${RDEPEND} virtual/httpd-php"
}

need_php()
{
	DEPEND="${DEPEND} dev-lang/php"
	RDEPEND="${RDEPEND} dev-lang/php"
	PHP_SHARED_CAT="php"
}

need_php_by_category()
{
	case "${CATEGORY}" in
		dev-php) need_php ;;
		dev-php4) need_php4 ;;
		dev-php5) need_php5 ;;
		*) die "I don't know which version of PHP packages in ${CATEGORY} require"
	esac
}

# call this function from pkg_setup if your PHP extension only works with
# specific SAPIs
#
# this function will disappear when USE-based deps are supported by
# Portage
#
# $1 ... a list of SAPI USE flags (eg cli, cgi, apache2)
#
# returns if any one of the listed SAPIs has been installed
# dies if none of the listed SAPIs has been installed

require_php_sapi_from()
{
	has_php

	local has_sapi=0
	local x

	einfo "Checking for compatible SAPI(s)"

	for x in $@ ; do
		if built_with_use =${PHP_PKG} ${x} ; then
			einfo "  Discovered compatible SAPI ${x}"
			has_sapi=1
		fi
	done

	if [[ ${has_sapi} == 1 ]]; then
		return
	fi

	eerror
	eerror "${PHP_PKG} needs to be re-installed with one of the following"
	eerror "USE flags enabled:"
	eerror
	eerror "  $@"
	eerror
	die "Re-install ${PHP_PKG}"
}

# call this function from pkg_setup if your package requires PHP compiled
# with specific USE flags
#
# this function will disappear when USE-based deps are supported by
# Portage
#
# $1 ... a list of USE flags
#
# returns if all of the listed USE flags are set
# dies if any of the listed USE flags are not set

require_php_with_use()
{
	has_php

	local missing_use=
	local x

	einfo "Checking for required PHP feature(s):"

	for x in $@ ; do
		if ! built_with_use =${PHP_PKG} ${x} ; then
			einfo "  Discovered missing USE flag ${x}"
			missing_use="${missing_use} ${x}"
		fi
	done

	if [[ -z ${missing_use} ]]; then
		return
	fi

	eerror
	eerror "${PHP_PKG} needs to be re-installed with all of the following"
	eerror "USE flags enabled:"
	eerror
	eerror "  $@"
	eerror
	die "Re-install ${PHP_PKG}"
}

# call this function from your pkg_setup, src_compile & src_install methods
# if you need to know where the PHP binaries are installed and their data

has_php()
{
	# if PHP_PKG is set, then we have remembered our PHP settings
	# from last time

	if [[ -n ${PHP_PKG} ]]; then
		return
	fi

	if [[ -z ${PHP_VERSION} ]]; then
		# detect which PHP version installed
		if has_version '=dev-lang/php-4*' ; then
			PHP_VERSION=4
		elif has_version '=dev-lang/php-5*' ; then
			PHP_VERSION=5
		else
			die "Unable to find an installed dev-lang/php package"
		fi
	fi

	# if we get here, then PHP_VERSION tells us which version of PHP we
	# want to use

	uses_php${PHP_VERSION}
}

# ========================================================================
# has_*() functions
#
# these functions return 0 if the condition is satisfied, or 1 otherwise
# ========================================================================

# check if our PHP was compiled with ZTS (Zend Thread Safety)

has_zts()
{
	has_php

	if built_with_use =${PHP_PKG} apache2 threads ; then
		return 0
	fi

	return 1
}

# check if our PHP was built with Hardened-PHP active

has_hardenedphp()
{
	has_php

	if built_with_use =${PHP_PKG} hardenedphp ; then
		return 0
	fi

	return 1
}

# ========================================================================
# require_*() functions
#
# These functions die() if PHP was built without the required USE flag(s)
# ========================================================================

# require a PHP built with PDO support for PHP5

require_pdo()
{
	has_php

	# do we have php5.1 installed?

	if [[ ${PHP_VERSION} == 4 ]] ; then
		eerror
		eerror "This package requires PDO."
		eerror "PDO is only available for PHP 5."
		eerror "Please install dev-lang/php-5*"
		eerror
		die "PHP 5 not installed"
	fi

	# was php5 compiled w/ pdo support?

	if built_with_use =${PHP_PKG} pdo ; then
		return
	fi

	# ok, maybe PDO was built as an external extension?

	if built_with_use =${PHP_PKG} pdo-external && has_version dev-php5/pecl-pdo ; then
		return
	fi

	# ok, as last resort, it suffices that pecl-pdo was installed to have PDO support

	if has_version dev-php5/pecl-pdo ; then
		return
	fi

	# if we get here, then we have no PDO support

	eerror
	eerror "No PDO extension for PHP found."
	eerror "Please note that PDO only exists for PHP 5."
	eerror "Please install a PDO extension for PHP 5,"
	eerror "you must install dev-lang/php-5.0* with"
	eerror "the 'pdo-external' USE flag or you must"
	eerror "install dev-lang/php-5.1* with either"
	eerror "the 'pdo' or the 'pdo-external' USE flags"
	eerror "turned on."
	eerror
	die "No PDO extension found for PHP 5"
}

# determines which installed PHP version has the CLI sapi
# useful for PEAR eclass, or anything which needs to run PHP
# scripts depending on the cli sapi

require_php_cli()
{
	# if PHP_PKG is set, then we have remembered our PHP settings
	# from last time

	if [[ -n ${PHP_PKG} ]]; then
		return
	fi

	# detect which PHP version installed
	if has_version '=dev-lang/php-4*' ; then
		pkg="`best_version '=dev-lang/php-4*'`"
		if built_with_use =${pkg} cli ; then
			PHP_VERSION=4
		fi
	elif has_version '=dev-lang/php-5*' ; then
		pkg="`best_version '=dev-lang/php-5*'`"
		if built_with_use =${pkg} cli ; then
			PHP_VERSION=5
		fi
	else
		die "Unable to find an installed dev-lang/php package"
	fi

	if [[ -z ${PHP_VERSION} ]]; then
		die "No PHP CLI installed"
	fi

	# if we get here, then PHP_VERSION tells us which version of PHP we
	# want to use

	uses_php${PHP_VERSION}
}

# determines which installed PHP version has the CGI sapi
# useful for anything which needs to run PHP scripts
# depending on the cgi sapi

require_php_cgi()
{
	# if PHP_PKG is set, then we have remembered our PHP settings
	# from last time

	if [[ -n ${PHP_PKG} ]]; then
		return
	fi

	# detect which PHP version installed
	if has_version '=dev-lang/php-4*' ; then
		pkg="`best_version '=dev-lang/php-4*'`"
		if built_with_use =${pkg} cgi ; then
			PHP_VERSION=4
		fi
	elif has_version '=dev-lang/php-5*' ; then
		pkg="`best_version '=dev-lang/php-5*'`"
		if built_with_use =${pkg} cgi ; then
			PHP_VERSION=5
		fi
	else
		die "Unable to find an installed dev-lang/php package"
	fi

	if [[ -z ${PHP_VERSION} ]]; then
		die "No PHP CGI installed"
	fi

	# if we get here, then PHP_VERSION tells us which version of PHP we
	# want to use

	uses_php${PHP_VERSION}
}

# require a PHP built with sqlite support

require_sqlite()
{
	has_php

	# has our PHP been built with sqlite?

	if built_with_use =${PHP_PKG} sqlite ; then
		return
	fi

	# do we have pecl-sqlite installed for PHP 4?

	if [[ ${PHP_VERSION} == 4 ]] ; then
		if has_version dev-php4/pecl-sqlite ; then
			return
		fi
	fi

	# if we get here, then we don't have any sqlite support for PHP installed

	eerror
	eerror "No sqlite extension for PHP found."
	eerror "Please install an sqlite extension for PHP,"
	eerror "this is done best by simply adding the"
	eerror "'sqlite' USE flag when emerging dev-lang/php."
	eerror
	die "No sqlite extension for PHP found"
}

# require a PHP built with GD support

require_gd()
{
	has_php

	# do we have the internal GD support installed?

	if built_with_use =${PHP_PKG} gd ; then
		return
	fi

	# ok, maybe GD was built using the external support?

	if built_with_use =${PHP_PKG} gd-external ; then
		return
	fi

	# if we get here, then we have no GD support

	eerror
	eerror "No GD support for PHP found."
	eerror "Please install the GD support for PHP,"
	eerror "you must install dev-lang/php with either"
	eerror "the 'gd' or the 'gd-external' USE flags"
	eerror "turned on."
	eerror
	die "No GD support found for PHP"
}

# ========================================================================
# Misc functions
#
# These functions provide miscellaneous checks and functionality.
# ========================================================================

# executes some checks needed when installing a binary PHP extension

php_binary_extension() {
	has_php

	# binary extensions do not support the change of PHP
	# API version, so they can't be installed when USE flags
	# are enabled wich change the PHP API version

	if built_with_use =${PHP_PKG} hardenedphp ; then
		eerror
		eerror "You cannot install binary PHP extensions"
		eerror "when the 'hardenedphp' USE flag is enabled!"
		eerror "Please reemerge dev-lang/php with the"
		eerror "'hardenedphp' USE flag turned off."
		eerror
		die "'hardenedphp' USE flag turned on"
	fi

	if built_with_use =${PHP_PKG} debug ; then
		eerror
		eerror "You cannot install binary PHP extensions"
		eerror "when the 'debug' USE flag is enabled!"
		eerror "Please reemerge dev-lang/php with the"
		eerror "'debug' USE flag turned off."
		eerror
		die "'debug' USE flag turned on"
	fi
}

# alternative to dodoc for use in our php eclasses and ebuilds
# stored here because depend.php gets always sourced everywhere
# in the PHP ebuilds and eclasses
# it simply is dodoc with a changed path to the docs
# no support for docinto is given!

dodoc-php()
{
if [ $# -lt 1 ] ; then
	echo "$0: at least one argument needed" 1>&2
	exit 1
fi

phpdocdir="${D}/usr/share/doc/${CATEGORY}/${PF}/"

if [ ! -d "${phpdocdir}" ] ; then
	install -d "${phpdocdir}"
fi

for x in "$@" ; do
	if [ -s "${x}" ] ; then
		install -m0644 "${x}" "${phpdocdir}"
		gzip -f -9 "${phpdocdir}/${x##*/}"
	elif [ ! -e "${x}" ] ; then
		echo "dodoc-php: ${x} does not exist" 1>&2
	fi
done
}
