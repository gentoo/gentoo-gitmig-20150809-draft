# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.1.12-r1.ebuild,v 1.5 2007/11/18 15:03:03 robbat2 Exp $

DESCRIPTION="memcached is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://www.danga.com/memcached/dist/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ~ppc ~ppc64 sparc x86"
IUSE="static perl doc"

DEPEND=">=dev-libs/libevent-0.6
		perl? ( dev-perl/Cache-Memcached )"

src_compile() {
	local myconf=""
	use static || myconf="--disable-static ${myconf}"
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dobin "${S}"/memcached
	dodoc "${S}"/{AUTHORS,COPYING,ChangeLog,INSTALL,NEWS,README}

	newconfd "${FILESDIR}/${PV}/conf" memcached

	newinitd "${FILESDIR}/${PV}/init" memcached

	doman "${S}"/doc/memcached.1

	if use doc; then
	  dodoc "${S}"/doc/{memory_management.txt,protocol.txt}
	fi
}
