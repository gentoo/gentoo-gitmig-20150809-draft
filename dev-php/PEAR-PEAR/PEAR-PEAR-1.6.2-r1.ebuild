# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR/PEAR-PEAR-1.6.2-r1.ebuild,v 1.10 2009/09/23 02:41:50 beandog Exp $

inherit depend.php

ARCHIVE_TAR="1.3.2"
CONSOLE_GETOPT="1.2.3"
STRUCTURES_GRAPH="1.0.2"
XML_RPC="1.5.1"
PEAR="${PV}"

[[ -z "${PEAR_CACHEDIR}" ]] && PEAR_CACHEDIR="/var/cache/pear"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

DESCRIPTION="PEAR Base System (PEAR, Archive_Tar, Console_Getopt, Structures_Graph, XML_RPC)."
HOMEPAGE="http://pear.php.net/"
SRC_URI="http://pear.php.net/get/Archive_Tar-${ARCHIVE_TAR}.tgz
		http://pear.php.net/get/Console_Getopt-${CONSOLE_GETOPT}.tgz
		http://pear.php.net/get/Structures_Graph-${STRUCTURES_GRAPH}.tgz
		http://pear.php.net/get/XML_RPC-${XML_RPC}.tgz
		http://pear.php.net/get/PEAR-${PEAR}.tgz"
LICENSE="LGPL-2.1 PHP-2.02 PHP-3 PHP-3.01 MIT"
SLOT="0"
IUSE=""

# we depend on a recent sandbox version to mitigate problems users
# have been experiencing
DEPEND="dev-lang/php
	>=sys-apps/sandbox-1.2.17
	!dev-php/pear
	!dev-php/PEAR-Archive_Tar
	!dev-php/PEAR-Console_Getopt
	!dev-php/PEAR-Structures_Graph
	!dev-php/PEAR-XML_RPC"
RDEPEND="dev-lang/php"

S=${WORKDIR}

pkg_setup() {
	has_php

	# we check that PHP was compiled with the correct USE flags
	if [[ ${PHP_VERSION} == "4" ]] ; then
		require_php_with_use cli pcre expat zlib
	else
		require_php_with_use cli pcre xml zlib
	fi
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/PEAR-${PV}
	epatch "${FILESDIR}"/${PV}-accept-encoding-bug_12116.patch # PEAR bug #12116
}

src_install() {
	require_php_cli

	# Prevent SNMP related sandbox violoation.
	addpredict /usr/share/snmp/mibs/.index
	addpredict /var/lib/net-snmp/

	mkdir -p PEAR/XML/RPC

	# Install PEAR Package.
	cp -r PEAR-${PEAR}/OS PEAR/
	cp -r PEAR-${PEAR}/PEAR PEAR/
	cp PEAR-${PEAR}/PEAR.php PEAR/PEAR.php
	cp PEAR-${PEAR}/System.php PEAR/System.php

	# Prepare /usr/bin/pear script.
	cp PEAR-${PEAR}/scripts/pearcmd.php PEAR/pearcmd.php
	sed -i "s:@pear_version@:${PEAR}:g" PEAR/pearcmd.php || die "sed failed"
	cp PEAR-${PEAR}/scripts/pear.sh PEAR/pear
	sed -i -e "s:@php_bin@:${PHPCLI}:g" \
		-e "s:@bin_dir@:/usr/bin:g" \
		-e "s:@php_dir@:/usr/share/php:g" \
		-e "s:-d output_buffering=1:-d output_buffering=1 -d memory_limit=32M:g" PEAR/pear || die "sed failed"

	# Prepare /usr/bin/peardev script.
	cp PEAR-${PEAR}/scripts/peardev.sh PEAR/peardev
	sed -i -e "s:@php_bin@:${PHPCLI}:g" \
		-e "s:@bin_dir@:/usr/bin:g" \
		-e "s:@php_dir@:/usr/share/php:g" PEAR/peardev || die "sed failed"

	# Prepare /usr/bin/pecl script.
	cp PEAR-${PEAR}/scripts/peclcmd.php PEAR/peclcmd.php
	sed -i "s:@pear_version@:${PEAR}:g" PEAR/peclcmd.php || die "sed failed"
	cp PEAR-${PEAR}/scripts/pecl.sh PEAR/pecl
	sed -i -e "s:@php_bin@:${PHPCLI}:g" \
		-e "s:@bin_dir@:/usr/bin:g" \
		-e "s:@php_dir@:/usr/share/php:g" PEAR/pecl || die "sed failed"

	# Prepare PEAR/Dependency2.php.
	sed -i "s:@PEAR-VER@:${PEAR}:g" PEAR/PEAR/Dependency2.php || die "sed failed"

	# Install Archive_Tar Package.
	cp -r Archive_Tar-${ARCHIVE_TAR}/Archive PEAR/

	# Install Console_Getopt Package.
	cp -r Console_Getopt-${CONSOLE_GETOPT}/Console PEAR/

	# Install Structures_Graph Package.
	cp -r Structures_Graph-${STRUCTURES_GRAPH}/Structures PEAR/

	# Install XML_RPC Package.
	cp XML_RPC-${XML_RPC}/RPC.php PEAR/XML/RPC.php
	cp XML_RPC-${XML_RPC}/Server.php PEAR/XML/RPC/Server.php

	# Finalize installation.
	cd PEAR
	insinto /usr/share/php
	doins -r Archive Console OS PEAR Structures XML *.php
	dobin pear peardev pecl

	insinto /etc
	doins "${FILESDIR}/pear.conf"
	sed -i -e "s|s:PHPCLILEN:\"PHPCLI\"|s:${#PHPCLI}:\"${PHPCLI}\"|g" \
		-e "s|s:CACHEDIRLEN:\"CACHEDIR\"|s:${#PEAR_CACHEDIR}:\"${PEAR_CACHEDIR}\"|g" "${D}/etc/pear.conf" || die "sed failed"

	keepdir "${PEAR_CACHEDIR}"
	fperms 755 "${PEAR_CACHEDIR}"
}

pkg_preinst() {
	rm -f "${ROOT}/etc/pear.conf"
}

pkg_postinst() {
	pear clear-cache

	# Update PEAR/PECL channels as needed, add new ones to the list if needed
	pearchans="pear.php.net pecl.php.net components.ez.no pear.phpdb.org pear.phing.info pear.symfony-project.com pear.phpunit.de pear.php-baustelle.de pear.zeronotice.org pear.phpontrax.com pear.agavi.org"

	for chan in ${pearchans} ; do
		pear channel-discover ${chan}
		pear channel-update ${chan}
	done
}
