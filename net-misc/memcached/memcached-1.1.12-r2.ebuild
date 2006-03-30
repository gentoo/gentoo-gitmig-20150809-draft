# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.1.12-r2.ebuild,v 1.4 2006/03/30 04:04:45 agriffis Exp $

inherit eutils

DESCRIPTION="memcached is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://www.danga.com/memcached/dist/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
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
	dobin ${S}/memcached
	dodoc ${S}/{AUTHORS,COPYING,ChangeLog,INSTALL,NEWS,README}

	insinto /etc/conf.d
	newins "${FILESDIR}/${PV}/conf" memcached

	exeinto /etc/init.d
	newexe "${FILESDIR}/${PV}/init" memcached

	doman ${S}/doc/memcached.1

	if use doc; then
	  dodoc ${S}/doc/{memory_management.txt,protocol.txt}
	fi
}

pkg_postinst() {
	enewuser memcached -1 -1 /dev/null daemon
}
