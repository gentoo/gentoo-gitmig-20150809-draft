# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-mailparse/PECL-mailparse-0.9.3.ebuild,v 1.5 2005/02/18 08:44:00 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_NAME="mailparse"
PHP_EXT_INI="yes"

inherit php-ext-source

IUSE=""
DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
HOMEPAGE="http://pear.php.net/mailparse"
SLOT="0"
MY_PN="mailparse"
SRC_URI="http://pear.php.net/get/${MY_PN}-${PV}.tgz"
S=${WORKDIR}/${MY_PN}-${PV}
LICENSE="PHP"
KEYWORDS="x86 ~ppc ~alpha ~sparc"

src_install() {
	php-ext-source_src_install
	dodoc CREDITS README
}
