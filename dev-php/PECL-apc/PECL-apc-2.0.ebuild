# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-apc/PECL-apc-2.0.ebuild,v 1.6 2004/11/29 12:34:29 blubb Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_NAME="apc"
PHP_EXT_INI="yes"

inherit php-ext-source

IUSE=""
DESCRIPTION="The Alternative PHP Cache"
HOMEPAGE="http://pecl.php.net/APC"
SLOT="0"
MY_PN="APC"
SRC_URI="http://pecl.php.net/get/${MY_PN}-${PV}.tgz"
S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="PHP"
KEYWORDS="x86 alpha ~sparc ppc ~amd64"
DEPEND="$DEPEND
	    !dev-php/turck-mmcache
		!dev-php/php-accelerator
		!dev-php/ioncube_loaders"

src_install () {
	php-ext-source_src_install
	dodoc CHANGELOG INSTALL LICENSE NOTICE
}
