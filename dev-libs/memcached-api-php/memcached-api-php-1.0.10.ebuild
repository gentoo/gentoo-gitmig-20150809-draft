# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/memcached-api-php/memcached-api-php-1.0.10.ebuild,v 1.1 2003/08/14 19:46:59 lisa Exp $

DESCRIPTION="PHP API for memcached"

HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="http://www.danga.com/memcached/dist/php-memcached-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}/php-memcached-${PV}

#where we're sending the API
APIDEST="/usr/lib/php/memcached"

src_compile() {
	#there's nothing to compile
	return
}

src_install() {
	#Just a file to mv. cool, huh?
	insinto ${APIDEST}
	doins ${S}/MemCachedClient.inc.php
	dodoc ${S}/Documentation

	einfo "The PHP API is installed to ${APIDEST}/MemCachedClient.inc.php"
	einfo "You may want to edit your php.ini to include_path that directory"
	echo
	einfo "Documentation can be found at /usr/share/doc/${P}/"
}
