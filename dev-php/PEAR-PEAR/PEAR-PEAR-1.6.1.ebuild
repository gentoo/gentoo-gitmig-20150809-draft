# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR/PEAR-PEAR-1.6.1.ebuild,v 1.7 2007/08/23 00:07:22 angelos Exp $

inherit depend.php

ARCHIVE_TAR="1.3.2"
CONSOLE_GETOPT="1.2.3"
STRUCTURES_GRAPH="1.0.2"
XML_RPC="1.5.1"
PEAR="1.6.1"

[[ -z "${PEAR_CACHEDIR}" ]] && PEAR_CACHEDIR="/var/cache/pear"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~s390 ~sh sparc x86"

DESCRIPTION="PEAR Base System (PEAR, Archive_Tar, Console_Getopt, Structures_Graph, XML_RPC)."
HOMEPAGE="http://pear.php.net/"
SRC_URI="http://pear.php.net/get/Archive_Tar-${ARCHIVE_TAR}.tgz
		http://pear.php.net/get/Console_Getopt-${CONSOLE_GETOPT}.tgz
		http://pear.php.net/get/Structures_Graph-${STRUCTURES_GRAPH}.tgz
		http://pear.php.net/get/XML_RPC-${XML_RPC}.tgz
		http://pear.php.net/get/PEAR-${PEAR}.tgz"
LICENSE="LGPL-2.1 PHP"
SLOT="0"
IUSE=""

# we deliberately force people to remove their old PEAR installations,
# and any package which may have put an old-style PEAR installation onto
# their box
# we also depend on a recent sandbox version to mitigate problems users
# have been experiencing

DEPEND="dev-lang/php
		!dev-php/php
		!dev-php/php-cgi
		!dev-php/mod_php
		!<dev-php/PEAR-PEAR-1.3.6-r2
		!dev-php/PEAR-Archive_Tar
		!dev-php/PEAR-Console_Getopt
		!dev-php/PEAR-XML_RPC
		>=sys-apps/sandbox-1.2.17"
RDEPEND="${DEPEND}"

pkg_setup() {
	# we call this here, to ensure that the eclass picks the right
	# version of php for the job
	require_php_cli

	# we check that PHP was compiled with the correct USE flags
	if [[ ${PHP_VERSION} == "4" ]] ; then
		require_php_with_use cli pcre expat zlib
	else
		require_php_with_use cli pcre xml zlib
	fi
}

src_install() {
	require_php_cli

	# Prevent SNMP related sandbox violoation.
	addpredict /usr/share/snmp/mibs/.index
	addpredict /var/lib/net-snmp/

	mkdir -p "${WORKDIR}/PEAR/XML/RPC"

	# Install PEAR Package.
	cp -r "${WORKDIR}/PEAR-${PEAR}/OS" "${WORKDIR}/PEAR/"
	cp -r "${WORKDIR}/PEAR-${PEAR}/PEAR" "${WORKDIR}/PEAR/"
	cp "${WORKDIR}/PEAR-${PEAR}/PEAR.php" "${WORKDIR}/PEAR/PEAR.php"
	cp "${WORKDIR}/PEAR-${PEAR}/System.php" "${WORKDIR}/PEAR/System.php"

	# Prepare /usr/bin/pear script.
	cp "${WORKDIR}/PEAR-${PEAR}/scripts/pearcmd.php" "${WORKDIR}/PEAR/pearcmd.php"
	sed -i "s:@pear_version@:${PEAR}:g" "${WORKDIR}/PEAR/pearcmd.php" || die "sed failed"
	cp "${WORKDIR}/PEAR-${PEAR}/scripts/pear.sh" "${WORKDIR}/PEAR/pear"
	sed -i "s:@php_bin@:${PHPCLI}:g" "${WORKDIR}/PEAR/pear" || die "sed failed"
	sed -i "s:@bin_dir@:/usr/bin:g" "${WORKDIR}/PEAR/pear" || die "sed failed"
	sed -i "s:@php_dir@:/usr/share/php:g" "${WORKDIR}/PEAR/pear" || die "sed failed"
	sed -i "s:-d output_buffering=1:-d output_buffering=1 -d memory_limit=32M:g" "${WORKDIR}/PEAR/pear" || die "sed failed"

	# Prepare /usr/bin/peardev script.
	cp "${WORKDIR}/PEAR-${PEAR}/scripts/peardev.sh" "${WORKDIR}/PEAR/peardev"
	sed -i "s:@php_bin@:${PHPCLI}:g" "${WORKDIR}/PEAR/peardev" || die "sed failed"
	sed -i "s:@bin_dir@:/usr/bin:g" "${WORKDIR}/PEAR/peardev" || die "sed failed"
	sed -i "s:@php_dir@:/usr/share/php:g" "${WORKDIR}/PEAR/peardev" || die "sed failed"

	# Prepare /usr/bin/pecl script.
	cp "${WORKDIR}/PEAR-${PEAR}/scripts/peclcmd.php" "${WORKDIR}/PEAR/peclcmd.php"
	sed -i "s:@pear_version@:${PEAR}:g" "${WORKDIR}/PEAR/peclcmd.php" || die "sed failed"
	cp "${WORKDIR}/PEAR-${PEAR}/scripts/pecl.sh" "${WORKDIR}/PEAR/pecl"
	sed -i "s:@php_bin@:${PHPCLI}:g" "${WORKDIR}/PEAR/pecl" || die "sed failed"
	sed -i "s:@bin_dir@:/usr/bin:g" "${WORKDIR}/PEAR/pecl" || die "sed failed"
	sed -i "s:@php_dir@:/usr/share/php:g" "${WORKDIR}/PEAR/pecl" || die "sed failed"

	# Prepare PEAR/Dependency2.php.
	sed -i "s:@PEAR-VER@:${PEAR}:g" "${WORKDIR}/PEAR/PEAR/Dependency2.php" || die "sed failed"

	# Install Archive_Tar Package.
	cp -r "${WORKDIR}/Archive_Tar-${ARCHIVE_TAR}/Archive" "${WORKDIR}/PEAR/"

	# Install Console_Getopt Package.
	cp -r "${WORKDIR}/Console_Getopt-${CONSOLE_GETOPT}/Console" "${WORKDIR}/PEAR/"

	# Install Structures_Graph Package.
	cp -r "${WORKDIR}/Structures_Graph-${STRUCTURES_GRAPH}/Structures" "${WORKDIR}/PEAR/"

	# Install XML_RPC Package.
	cp "${WORKDIR}/XML_RPC-${XML_RPC}/RPC.php" "${WORKDIR}/PEAR/XML/RPC.php"
	cp "${WORKDIR}/XML_RPC-${XML_RPC}/Server.php" "${WORKDIR}/PEAR/XML/RPC/Server.php"

	# Finalize installation.
	cd "${WORKDIR}/PEAR"
	insinto /usr/share/php
	doins -r Archive Console OS PEAR Structures XML *.php
	dobin pear peardev pecl

	insinto /etc
	doins "${FILESDIR}/pear.conf"
	sed -e "s|s:PHPCLILEN:\"PHPCLI\"|s:${#PHPCLI}:\"${PHPCLI}\"|g" -i "${D}/etc/pear.conf" || die "sed failed"
	sed -e "s|s:CACHEDIRLEN:\"CACHEDIR\"|s:${#PEAR_CACHEDIR}:\"${PEAR_CACHEDIR}\"|g" -i "${D}/etc/pear.conf" || die "sed failed"

	keepdir "${PEAR_CACHEDIR}"
	fperms 755 "${PEAR_CACHEDIR}"
}

pkg_preinst() {
	rm -f "${ROOT}/etc/pear.conf"
}

pkg_postinst() {
	pear clear-cache

	# Update PEAR/PECL channels as needed, add new ones to the list if needed
	pearchans="pear.php.net pecl.php.net components.ez.no pear.phpdb.org pear.phing.info pear.symfony-project.com pear.phpunit.de pear.php-baustelle.de"

	for chan in ${pearchans} ; do
		pear channel-discover ${chan}
		pear channel-update ${chan}
	done
}
