# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.1.12_rc1.ebuild,v 1.1 2005/01/15 02:39:45 lisa Exp $


PATCHLEVEL="1.1.12"

DESCRIPTION="memcached is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

HOMEPAGE="http://www.danga.com/memcached/"

MY_PV="${PV/_rc/-rc}"
S="${WORKDIR}/${PN}-${MY_PV}"
SRC_URI="http://www.danga.com/memcached/dist/testing/memcached-${MY_PV}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="static perl php"

DEPEND=">=dev-libs/libevent-0.6
	perl? ( dev-perl/Cache-Memcached )
	php? ( dev-libs/memcached-api-php )"

src_compile() {
	einfo $S
	local myconf=""
	use static || myconf="--disable-static ${myconf}"
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dobin ${S}/memcached
	dodoc ${S}/{AUTHORS,COPYING,ChangeLog,INSTALL,NEWS,README}

	insinto /etc/conf.d
	newins "${FILESDIR}/${PATCHLEVEL}/conf" memcached

	exeinto /etc/init.d
	newexe "${FILESDIR}/${PATCHLEVEL}/init" memcached
}

pkg_postinst() {
	if ! use php; then
		ewarn "This package uses a special \"php\" USE flag to include the PHP"
		ewarn "API. If you emerged this without setting that USE flag, you can"
		ewarn "still get the API by doing:"
		einfo "   emerge dev-libs/memcached-api-php"
		echo
	fi
}
