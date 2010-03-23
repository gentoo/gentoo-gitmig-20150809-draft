# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcached/libmemcached-0.38.ebuild,v 1.1 2010/03/23 03:38:47 robbat2 Exp $

EAPI=2

inherit eutils

DESCRIPTION="a C client library to the memcached server"
HOMEPAGE="http://tangent.org/552/libmemcached.html"
SRC_URI="http://download.tangent.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~sparc-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug hsieh"

DEPEND="net-misc/memcached"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.28-runtestsasuser.patch"
}

src_configure() {
	econf \
		$(use_with debug debug) \
		$(use_with hsieh hsieh_hash)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# remove manpage to avoid collision, see bug #299330
	rm -f "${D}"/usr/share/man/man1/memdump.* || die "Install failed"
	newman docs/memdump.1 memcached_memdump.1
}

src_test() {
	emake -j1 test-docs test-mem test-hash test-plus || die "Tests failed"
}
