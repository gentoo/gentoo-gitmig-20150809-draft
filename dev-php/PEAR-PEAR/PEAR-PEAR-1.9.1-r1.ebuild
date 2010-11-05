# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR/PEAR-PEAR-1.9.1-r1.ebuild,v 1.4 2010/11/05 04:18:21 jer Exp $

EAPI="2"

inherit depend.php

PEAR="${PV}"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86"

DESCRIPTION="PEAR Base System"
HOMEPAGE="http://pear.php.net/package/PEAR"
SRC_URI="http://pear.php.net/get/PEAR-${PEAR}.tgz"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
		|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
		dev-lang/php[cli,xml,zlib]"

S="${WORKDIR}"

pkg_setup() {
	has_php

	[[ -z "${PEAR_CACHEDIR}" ]] && PEAR_CACHEDIR="/var/cache/pear"
	[[ -z "${PEAR_DOWNLOADDIR}" ]] && PEAR_DOWNLOADDIR="/var/tmp/pear"
	[[ -z "${PEAR_TEMPDIR}" ]] && PEAR_TEMPDIR="/tmp"

	elog
	elog "cache_dir is set to: ${PEAR_CACHEDIR}"
	elog "download_dir is set to: ${PEAR_DOWNLOADDIR}"
	elog "temp_dir is set to: ${PEAR_TEMPDIR}"
	elog
	elog "If you want to change the above values, you need to set"
	elog "PEAR_CACHEDIR, PEAR_DOWNLOADDIR and PEAR_TEMPDIR variable(s)"
	elog "accordingly in /etc/make.conf and re-emerge ${PN}."
	elog
}

src_install() {
	# Prevent SNMP related sandbox violoation.
	addpredict /usr/share/snmp/mibs/.index
	addpredict /var/lib/net-snmp/

	# install PEAR package
	cd "${S}"/PEAR-${PEAR}

	insinto /usr/share/php
	doins -r PEAR/
	doins -r OS/
	doins PEAR.php PEAR5.php System.php
	doins scripts/pearcmd.php
	doins scripts/peclcmd.php

	newbin scripts/pear.sh pear
	newbin scripts/peardev.sh peardev
	newbin scripts/pecl.sh pecl

	# adjust some scripts for current version
	for i in pearcmd.php peclcmd.php ; do
		dosed "s:@pear_version@:${PEAR}:g" /usr/share/php/${i}
	done

	for i in pear peardev pecl ; do
		dosed "s:@php_bin@:${PHPCLI}:g" /usr/bin/${i}
		dosed "s:@bin_dir@:/usr/bin:g" /usr/bin/${i}
		dosed "s:@php_dir@:/usr/share/php:g" /usr/bin/${i}
	done
	dosed "s:-d output_buffering=1:-d output_buffering=1 -d memory_limit=32M:g" /usr/bin/pear

	dosed "s:@package_version@:${PEAR}:g" /usr/share/php/PEAR/Command/Package.php
	dosed "s:@PEAR-VER@:${PEAR}:g" /usr/share/php/PEAR/Dependency2.php
	dosed "s:@PEAR-VER@:${PEAR}:g" /usr/share/php/PEAR/PackageFile/Parser/v1.php
	dosed "s:@PEAR-VER@:${PEAR}:g" /usr/share/php/PEAR/PackageFile/Parser/v2.php

	# finalize install
	insinto /etc
	newins "${FILESDIR}"/pear.conf-r1 pear.conf
	dosed "s|s:PHPCLILEN:\"PHPCLI\"|s:${#PHPCLI}:\"${PHPCLI}\"|g" /etc/pear.conf
	dosed "s|s:CACHEDIRLEN:\"CACHEDIR\"|s:${#PEAR_CACHEDIR}:\"${PEAR_CACHEDIR}\"|g" /etc/pear.conf
	dosed "s|s:DOWNLOADDIRLEN:\"DOWNLOADDIR\"|s:${#PEAR_DOWNLOADDIR}:\"${PEAR_DOWNLOADDIR}\"|g" /etc/pear.conf
	dosed "s|s:TEMPDIRLEN:\"TEMPDIR\"|s:${#PEAR_TEMPDIR}:\"${PEAR_TEMPDIR}\"|g" /etc/pear.conf

	[[ "${PEAR_TEMPDIR}" != "/tmp" ]] && keepdir "${PEAR_TEMPDIR}"
	keepdir "${PEAR_CACHEDIR}"
	diropts -m1777
	keepdir "${PEAR_DOWNLOADDIR}"
}

pkg_preinst() {
	rm -f "${ROOT}/etc/pear.conf"
}
