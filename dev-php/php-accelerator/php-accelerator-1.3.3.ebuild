# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-accelerator/php-accelerator-1.3.3.ebuild,v 1.6 2004/01/05 21:26:00 stuart Exp $

DESCRIPTION="The ionCube PHP Accelerator"
HOMEPAGE="http://www.php-accelerator.co.uk/"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~x86"
IUSE=""
RESTRICT="nomirror nostrip"
DEPEND="!dev-php/turck-mmcache
	    !dev-php/PECL-apc"

# Detect machine type
PHP_NO_BUILD=
case ${MACHTYPE} in
alpha-pc-linux-gnu)
	OS="linux"
	CPU="alpha"
	;;
i686-pc-linux-gnu)
	OS="linux"
	CPU="i686"
	;;
*)
	PHPA_NO_BUILD=1
	;;
esac

# Detect glibc version
GLIBC_VER="2.1.3"

# use phpAccelerator for PHP 4.3.0
PHP_VER="4.3.0"
PHPA_VER="${PV}r2"
PHPA="php_accelerator-${PHPA_VER}_php-${PHP_VER}_${OS}_${CPU}-glibc${GLIBC_VER}"

SRC_URI="http://www.php-accelerator.co.uk/releases/${OS}_${CPU}-glibc${GLIBC_VER}/${PHPA_VER}_${PHP_VER}/${PHPA}.tgz"
DEPEND=""
RDEPEND=">=virtual/glibc-${GLIBC_VER} >=virtual/php-${PHP_VER}"

S=${WORKDIR}/${PHPA}

PHP_EXT_NAME="php_accelerator_${PHPA_VER}"
PHP_EXT_ZENDEXT="yes"

inherit php-ext-base

pkg_setup() {

	if [ -n "${PHPA_NO_BUILD}" ]; then
		die "There is no build for your machine type (${MACHTYPE})"
	fi

}

src_install() {
	insinto ${EXT_DIR}
	doins ${PHP_EXT_NAME}.so
	dobin phpa_cache_admin
	dodoc CONFIGURATION INSTALL release_notes phpa_cache_admin *.gif

	php-ext-base_src_install

	php-ext-base_addtoinifiles "phpa.shm_user" '"apache"'
	php-ext-base_addtoinifiles "phpa.shm_group" '"apache"'
}
