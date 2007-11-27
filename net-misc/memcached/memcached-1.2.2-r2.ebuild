# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.2.2-r2.ebuild,v 1.1 2007/11/27 00:04:37 robbat2 Exp $

inherit eutils

DESCRIPTION="High-performance, distributed memory object caching system"
HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="http://www.danga.com/memcached/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nptl"

RDEPEND=">=dev-libs/libevent-0.6
		>=dev-perl/Cache-Memcached-1.24"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-fbsd.patch"
	epatch "${FILESDIR}/${P}-p-threads.patch"
}

src_compile() {
	econf $(use_enable nptl threads)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dobin scripts/memcached-tool

	dodoc AUTHORS ChangeLog NEWS README TODO doc/{CONTRIBUTORS,*.txt}

	newconfd "${FILESDIR}"/1.1.13/conf memcached
	newinitd "${FILESDIR}"/1.1.13/init memcached
}

pkg_postinst() {
	enewuser memcached -1 -1 /dev/null daemon

	elog "With this version of Memcached Gentoo now supports multiple instances."
	elog "To enable this you must create a symlink in /etc/init.d/ for each instance"
	elog "to /etc/init.d/memcached and create the matching conf files in /etc/conf.d/"
	elog "Please see Gentoo bug #122246 for more info"
}
