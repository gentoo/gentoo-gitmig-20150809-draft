# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg/phpdbg-2.11.32.ebuild,v 1.1 2005/02/19 15:04:20 sebastian Exp $

PHP_EXT_NAME="dbg"
PHP_EXT_ZENDEXT="no"
inherit php-ext-source
IUSE=""
S="${WORKDIR}/dbg-${PV}${PL}"
DESCRIPTION="A PHP debugger useable with some editors like phpedit."
SRC_URI="mirror://sourceforge/dbg2/dbg-${PV}${PL}-src.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
LICENSE="dbgphp"
SLOT="0"
DEPEND="virtual/php"

# support for ppc or others?
KEYWORDS="~x86 ~sparc ~amd64"

src_compile() {
	# phpdbg does not work with Zend Thread Safety (ZTS)
	# so about if we are using Apache 2 with an MPM that would
	# require ZTS.
	if has_version '>=net-www/apache-2*'; then
		APACHE2_MPM="`/usr/sbin/apache2 -l | egrep 'worker|perchild|leader|threadpool|prefork'|cut -d. -f1|sed -e 's/^[[:space:]]*//g;s/[[:space:]]+/ /g;'`"
		case "${APACHE2_MPM}" in
			*prefork*) ;;
			*) eerror "phpdbg does not yet work with the Apache 2 MPM in use." ; die ;;
		esac;
	fi

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
