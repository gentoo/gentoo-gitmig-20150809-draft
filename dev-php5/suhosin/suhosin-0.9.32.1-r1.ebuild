# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/suhosin/suhosin-0.9.32.1-r1.ebuild,v 1.2 2010/10/11 23:26:22 flameeyes Exp $

EAPI="2"

PHP_EXT_NAME="suhosin"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1 eutils

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="Suhosin is an advanced protection system for PHP installations."
HOMEPAGE="http://www.suhosin.org/"
SRC_URI="http://download.suhosin.org/${P}.tar.gz"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[unicode]"
RDEPEND="${DEPEND}"

need_php_by_category

src_unpack() {
	PHP_EXT_SKIP_PHPIZE=yes php-ext-source-r1_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libcrypt.patch
	php-ext-source-r1_phpize
}

src_install() {
	php-ext-source-r1_src_install
	dodoc-php CREDITS

	for inifile in ${PHPINIFILELIST} ; do
		insinto "${inifile/${PHP_EXT_NAME}.ini/}"
		insopts -m644
		doins "suhosin.ini"
	done
}

src_test() {
	# Makefile passes a hard-coded -d extension_dir=./modules, we move the lib
	# away from there in src_compile
	ln -s "${WORKDIR}/${PHP_EXT_NAME}-default.so" "${S}/modules/${PHP_EXT_NAME}.so"

	NO_INTERACTION="yes" emake test

}
