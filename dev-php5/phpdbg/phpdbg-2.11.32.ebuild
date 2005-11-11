# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpdbg/phpdbg-2.11.32.ebuild,v 1.3 2005/11/11 21:31:14 voxus Exp $

PHP_EXT_NAME="dbg"
PHP_EXT_ZENDEXT="no"
inherit php-ext-source-r1
IUSE=""
S="${WORKDIR}/dbg-${PV}${PL}"
DESCRIPTION="A PHP debugger useable with some editors like phpedit."
SRC_URI="mirror://sourceforge/dbg2/dbg-${PV}${PL}-src.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
LICENSE="dbgphp"
SLOT="0"

KEYWORDS="~ppc ~sparc ~x86 ~amd64"

need_php_by_category

src_compile() {
		# phpdbg does not work with Zend Thread Safety (ZTS)
		# so abort if we are using PHP compiled with ZTS.
		if has_zts ; then
			eerror "phpdbg doesn't work with a ZTS enabled PHP."
			eerror "Please disable ZTS by turning the 'threads'"
			eerror "USE flag off when you compile dev-lang/php."
			die "phpdbg does not support ZTS"
		fi

	my_conf="--enable-dbg=shared --with-dbg-profiler"
	php-ext-source-r1_src_compile
}

src_install () {
	php-ext-source-r1_src_install
	dodoc AUTHORS COPYING INSTALL
	php-ext-base-r1_addtoinifiles "[Debugger]"
	php-ext-base-r1_addtoinifiles "debugger.enabled" "on"
	php-ext-base-r1_addtoinifiles "debugger.profiler_enabled" "on"
}

pkg_postinst() {
	einfo "Please reload Apache to activate the changes"
}

pkg_postrm() {
	einfo "You need to remove all lines referring to the debugger, and"
	einfo "extension=dbg.so. Please reload Apache to activate the changes."
}
