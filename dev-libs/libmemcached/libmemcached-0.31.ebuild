# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcached/libmemcached-0.31.ebuild,v 1.7 2010/04/10 13:42:10 armin76 Exp $

inherit eutils

DESCRIPTION="a C client library to the memcached server"
HOMEPAGE="http://tangent.org/552/libmemcached.html"
SRC_URI="http://download.tangent.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~sparc-fbsd"
IUSE="debug hsieh"

DEPEND="net-misc/memcached"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.28-runtestsasuser.patch
	epatch "${FILESDIR}"/${PN}-0.28-removebogustest.patch
}

src_compile() {
	econf \
		$(use_with debug debug) \
		$(use_enable hsieh hsieh_hash)
	emake || die "Build failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

src_test() {
	emake test || die "Tests failed"
}
