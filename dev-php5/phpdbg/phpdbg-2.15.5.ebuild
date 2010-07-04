# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpdbg/phpdbg-2.15.5.ebuild,v 1.2 2010/07/04 21:48:24 mabi Exp $

PHP_EXT_NAME="dbg"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="A PHP debugger useable with some editors like phpedit."
HOMEPAGE="http://dd.cron.ru/dbg/"
SRC_URI="mirror://sourceforge/dbg2/dbg-${PV}.tar.gz"
LICENSE="dbgphp"
SLOT="0"
IUSE=""

DEPEND="<dev-lang/php-5.3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dbg-${PV}"

need_php_by_category

pkg_setup() {
	has_php

	# phpdbg does not work with Zend Thread Safety (ZTS),
	# so abort if we're using PHP compiled with ZTS.
	if has_zts ; then
		eerror "phpdbg doesn't work with a ZTS enabled PHP."
		eerror "Please disable ZTS by turning the 'threads'"
		eerror "USE flag off when you compile dev-lang/php."
		die "phpdbg does not support ZTS"
	fi
}

src_compile() {
	my_conf="--enable-dbg=shared --with-dbg-profiler"
	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install
	dodoc-php AUTHORS COPYING INSTALL

	php-ext-base-r1_addtoinifiles "[Debugger]"
	php-ext-base-r1_addtoinifiles "debugger.enabled" "on"
	php-ext-base-r1_addtoinifiles "debugger.profiler_enabled" "on"
}
