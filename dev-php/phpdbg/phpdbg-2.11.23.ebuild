# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg/phpdbg-2.11.23.ebuild,v 1.2 2004/01/05 04:33:34 robbat2 Exp $

PHP_EXT_NAME="dbg"
PHP_EXT_ZENDEXT="no"
inherit php-ext-source

S="${WORKDIR}/dbg-${PV}-src"
DESCRIPTION="A PHP debugger useable with some editors like phpedit."
SRC_URI="http://dd.cron.ru/dbg/dnld/dbg-${PV}${PL}-src.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
LICENSE="dbgphp"
SLOT="0"
DEPEND="virtual/php"

# support for ppc or others?
KEYWORDS="x86 sparc "

src_compile() {
	myconf="--enable-dbg=shared --with-dbg-profiler --with-php-config=/usr/bin/php-config"
	php-ext-source_src_compile
}

src_install () {
	php-ext-source_src_install
	dodoc AUTHORS COPYING INSTALL
}

pkg_postinst() {
	php-ext-base_addtoinifiles "extension" "/etc/php4/lib/dbg.so"
	php-ext-base_addtoinifiles "[Debugger]"
	php-ext-base_addtoinifiles "debugger.enabled" "on"
	php-ext-base_addtoinifiles "debugger.profiler_enabled" "on"
	einfo "Please reload Apache to activate the changes"
}

pkg_postrm() {
	einfo "You need to remove all lines referring to the debugger, and"
	einfo "extension=dbg.so. Please reload Apache to activate the changes."
}
