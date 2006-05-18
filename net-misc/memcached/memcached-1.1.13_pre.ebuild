# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.1.13_pre.ebuild,v 1.1 2006/05/18 03:28:40 lisa Exp $

DESCRIPTION="memcached is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load."

HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://www.danga.com/memcached/dist/${P/_/-}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="static perl"

DEPEND=">=dev-libs/libevent-0.6
	perl? ( dev-perl/Cache-Memcached )"
S="${WORKDIR}/${P/_/-}"

src_compile() {
	einfo `pwd`
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
	newins "${FILESDIR}/${PV}/conf" memcached

	exeinto /etc/init.d
	newexe "${FILESDIR}/${PV}/init" memcached
}
