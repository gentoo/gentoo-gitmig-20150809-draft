# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg/phpdbg-2.10-r1.ebuild,v 1.3 2002/07/17 03:24:39 rphillips Exp $

PL="pl3"
S="${WORKDIR}/dbg-${PV}${PL}"
DESCRIPTION="A PHP debugger useable with some editors like phpedit."
SRC_URI="http://dd.cron.ru/dbg/dnld/dbg-${PV}${PL}.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
LICENSE="dbgphp"
SLOT="0"
DEPEND="virtual/php"

# support for ppc or others?
KEYWORDS="x86"

src_unpack() {
	unpack "dbg-${PV}pl3.tar.gz"
	cd "${S}"
}

src_compile() {
	phpize
	./configure --enable-dbg=shared --with-dbg-profiler 
	emake
}

src_install () {
	insinto /etc/php4/lib
	doins modules/dbg.so
	dodoc AUTHORS COPYING INSTALL
}

pkg_postinst() {
	echo "Performing post-installation routines for ${P}."

	if [ `cat /etc/php4/php.ini | grep extension=/etc/php4/lib/dbg.so` ]; then
	    einfo No changes made in php.ini
	else
			echo extension=/etc/php4/lib/dbg.so >> /etc/php4/php.ini
	fi
	
	einfo Please reload Apache to activate the changes
	
}

pkg_prerm() {
	echo "Performing pre-removal routines for ${P}."
	mv /etc/php4/php.ini /etc/php4/php.ini.old
	cat /etc/php4/php.ini.old | sed "s/extension=\/etc\/php4\/lib\/dbg.so//g" > /etc/php4/php.ini
	rm /etc/php4/php.ini.old
}

pkg_postrm() {
	einfo Please reload Apache to activate the changes

}
				
