# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug/xdebug-2.0.0_beta2.ebuild,v 1.4 2005/03/20 18:45:39 weeve Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_PECL_PKG="xdebug"
PHP_EXT_NAME="xdebug"
PHP_EXT_INI="yes"
PHP_EXT_PECL_FILENAME=""

inherit php-ext-pecl

IUSE="libedit"
DESCRIPTION="A PHP Debugging and Profiling extension."
HOMEPAGE="http://xdebug.org/"
MY_P="${P/_/}"
SRC_URI="http://xdebug.org/files/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"
SLOT="0"
LICENSE="Xdebug"
KEYWORDS="~x86 ~sparc"
DEPEND="${DEPEND}
	libedit? ( dev-libs/libedit )"

src_compile() {
	php-ext-pecl_src_compile

	cd ${S}/debugclient
	econf $(use_with libedit) || die
	emake || die
}

src_install() {
	php-ext-pecl_src_install

	cd ${S}/debugclient
	mv debugclient xdebug-client
	dobin xdebug-client
}
