# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-mailparse/PECL-mailparse-0.9.3-r1.ebuild,v 1.2 2004/05/30 18:25:38 kloeri Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
SLOT="0"
LICENSE="PHP"
KEYWORDS="x86 ~ppc ~alpha ~sparc"

src_install() {
	php-ext-pecl_src_install
	dodoc README
}
