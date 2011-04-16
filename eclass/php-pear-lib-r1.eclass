# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-pear-lib-r1.eclass,v 1.22 2011/04/16 12:19:00 olemarkus Exp $
#
# Author: Luca Longinotti <chtekk@gentoo.org>

# @ECLASS: php-pear-lib-r1.eclass
# @MAINTAINER:
# Gentoo PHP team <php-bugs@gentoo.org>
# @BLURB: Provides means for an easy installation of PEAR-based libraries.
# @DESCRIPTION:
# This class provides means for an easy installation of PEAR-based libraries,
# such as Creole, Jargon, Phing etc., while retaining the functionality to put
# the libraries into version-dependant directories.

inherit depend.php multilib

EXPORT_FUNCTIONS pkg_setup src_install

DEPEND="dev-lang/php
		 >=dev-php/pear-1.9.0"
RDEPEND="${DEPEND}"


if [[ -n $PHP_PEAR_CHANNEL ]] ; then
	PHP_PEAR_PV=${PV/_rc/RC}
	[[ -z ${PHP_PEAR_PN} ]] && die "Missing PHP_PEAR_PN. Please notify the maintainer"
	PHP_PEAR_P=${PHP_PEAR_PN}-${PHP_PEAR_PV}

	S=${WORKDIR}/${PHP_PEAR_P}

	SRC_URI="http://${PHP_PEAR_CHANNEL}/get/${PHP_PEAR_P}.tgz"
fi


# @FUNCTION: php-pear-lib-r1_pkg_setup
# @DESCRIPTION
# Adds required PEAR channel if necessary
php-pear-lib-r1_pkg_setup() {
	if [[ -n $PHP_PEAR_CHANNEL ]] ; then
		if [[ -f $PHP_PEAR_CHANNEL ]]; then
		 	pear channel-add $PHP_PEAR_CHANNEL
		else		
			pear channel-discover $PHP_PEAR_CHANNEL
			pear channel-update $PHP_PEAR_CHANNEL
		fi
	fi
}


# @FUNCTION: php-pear-lib-r1_src_install
# @DESCRIPTION:
# Takes care of standard install for PEAR-based libraries.
php-pear-lib-r1_src_install() {
	has_php

	# SNMP support
	addpredict /usr/share/snmp/mibs/.index
	addpredict /var/lib/net-snmp/
	addpredict /session_mm_cli0.sem

	PHP_BIN="/usr/bin/php"

	cd "${S}"

	if [[ -f "${WORKDIR}"/package2.xml ]] ; then
		mv -f "${WORKDIR}/package2.xml" "${S}"
		local WWW_DIR="/usr/share/webapps/${PN}/${PVR}/htdocs"
		peardev -d php_bin="${PHP_BIN}" -d www_dir="${WWW_DIR}" \
			install --force --loose --nodeps --offline --packagingroot="${D}" \
			"${S}/package2.xml" || die "Unable to install PEAR package"
	else
		mv -f "${WORKDIR}/package.xml" "${S}"
		local WWW_DIR="/usr/share/webapps/${PN}/${PVR}/htdocs"
		peardev -d php_bin="${PHP_BIN}" -d www_dir="${WWW_DIR}" \
			install --force --loose --nodeps --offline --packagingroot="${D}" \
			"${S}/package.xml" || die "Unable to install PEAR package"
	fi

	rm -Rf "${D}/usr/share/php/.channels" \
	"${D}/usr/share/php/.depdblock" \
	"${D}/usr/share/php/.depdb" \
	"${D}/usr/share/php/.filemap" \
	"${D}/usr/share/php/.lock" \
	"${D}/usr/share/php/.registry"

	# install to the correct phpX folder, if not specified
	# /usr/share/php will be kept, also sedding to substitute
	# the path, many files can specify it wrongly
	if [[ -n "${PHP_SHARED_CAT}" ]] && [[ "${PHP_SHARED_CAT}" != "php" ]] ; then
		mv -f "${D}/usr/share/php" "${D}/usr/share/${PHP_SHARED_CAT}" || die "Unable to move files"
		find "${D}/" -type f -exec sed -e "s|/usr/share/php|/usr/share/${PHP_SHARED_CAT}|g" -i {} \; \
			|| die "Unable to change PHP path"
		einfo
		einfo "Installing to /usr/share/${PHP_SHARED_CAT} ..."
		einfo
	else
		einfo
		einfo "Installing to /usr/share/php ..."
		einfo
	fi
}
