# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.1.11.ebuild,v 1.3 2004/07/17 09:44:52 dholm Exp $

DESCRIPTION="memcached is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://www.danga.com/memcached/dist/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE="static perl php"

DEPEND=">=dev-libs/libevent-0.6
	perl? ( dev-libs/memcached-api-perl )
	php? ( dev-libs/memcached-api-php )
"

#RDEPEND=""

src_compile() {
	local myconf=""
	use static || myconf="--disable-static ${myconf} "
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dobin ${S}/memcached
	dodoc ${S}/{AUTHORS,COPYING,ChangeLog,INSTALL,NEWS,README}

	insinto /etc/conf.d
	newins "${FILESDIR}/conf" memcached

	exeinto /etc/init.d
	newexe "${FILESDIR}/init" memcached
}


pkg_postinst() {
	if ! use php; then
		ewarn "This package uses a special \"php\" USE flag to include the PHP"
		ewarn "API. If you emerged this without setting that USE flag, you can"
		ewarn "still get the API by doing:"
		einfo "   emerge dev-libs/memcached-api-php"
		echo
	fi
	ewarn "Do not forget to run etc-update, there are new config and init scripts!"
}
