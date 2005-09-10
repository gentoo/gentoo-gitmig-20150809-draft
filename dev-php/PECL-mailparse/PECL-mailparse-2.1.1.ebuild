# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-mailparse/PECL-mailparse-2.1.1.ebuild,v 1.3 2005/09/10 23:11:37 agriffis Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
SLOT="0"
LICENSE="PHP"
KEYWORDS="alpha ~ppc ~sparc x86"

src_install() {
	php-ext-pecl_src_install
	dodoc README
}
