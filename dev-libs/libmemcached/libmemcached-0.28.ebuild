# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcached/libmemcached-0.28.ebuild,v 1.1 2009/05/05 19:37:00 robbat2 Exp $

inherit eutils

DESCRIPTION="a C client library to the memcached server"
HOMEPAGE="http://tangent.org/552/libmemcached.html"
SRC_URI="http://download.tangent.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86"
IUSE="test"

DEPEND="net-misc/memcached"
RDEPEND="${DEPEND}"

#RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.28-runtestsasuser.patch
	epatch "${FILESDIR}"/${PN}-0.28-removebogustest.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

src_test() {
	vecho ">>> Test phase [test]: ${CATEGORY}/${PF}"
	emake test || die "tests failed"
	vecho ">>> Test phase [none]: ${CATEGORY}/${PF}"
}

