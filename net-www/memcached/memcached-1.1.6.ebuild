# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/memcached/memcached-1.1.6.ebuild,v 1.2 2003/09/06 01:54:08 msterret Exp $

DESCRIPTION="memcached is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://www.danga.com/memcached/${P}.tar.gz"

LICENSE="BSD GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="static perl"

DEPEND=">=dev-libs/libevent-0.6
	>=dev-libs/judy-20020627
	perl? ( dev-lang/perl )
"

#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	local myconf=""
	use static || myconf="--disable-static ${myconf} "
	econf ${myconf}
	emake || die
}

src_install() {
	dobin ${S}/memcached
	dodoc ${S}/{AUTHORS,COPYING,ChangeLog,INSTALL,NEWS,README}

	dodir /usr/lib/php/memcached
	insinto /usr/lib/php/memcached
	doins ${S}/api/php/MemCachedClient.inc.php

	if use perl; then
		insinto /usr/lib/perl5/vendor_perl
		doins ${S}/api/perl/MemCachedClient.pm
	fi

	insinto /etc/conf.d
	newins "${FILESDIR}/conf" memcached

	exeinto /etc/init.d
	newexe "${FILESDIR}/init" memcached
}


pkg_postinst() {
	einfo "This package installs two APIs for usage"
	einfo "/usr/lib/perl5/vendor_perl/MemCachedClient.pm for perl"
	einfo "/usr/lib/php/memcached/MemCachedClient.inc.php"
	echo ""
	ewarn "To use the PHP one you may have to modify your php.ini"
	ewarn "to include that directory"
}
