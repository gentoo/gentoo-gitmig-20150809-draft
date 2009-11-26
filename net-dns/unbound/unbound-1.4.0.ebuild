# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/unbound/unbound-1.4.0.ebuild,v 1.1 2009/11/26 15:55:56 matsuu Exp $

EAPI="2"

inherit autotools eutils multilib

DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"
SRC_URI="http://unbound.net/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libevent python static test threads"

RDEPEND=">=dev-libs/openssl-0.9.8
	>=net-libs/ldns-1.4
	libevent? ( dev-libs/libevent )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	test? (
		net-dns/ldns-utils[examples]
		dev-util/splint
	)"

pkg_setup() {
	enewgroup unbound
	enewuser unbound -1 -1 /etc/unbound unbound
}

src_prepare() {
	sed -i -e "s:\(withval\|thedir\)/lib:\1/$(get_libdir):" configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--with-pidfile=/var/run/unbound.pid \
		--with-ldns=/usr \
		$(use_enable debug) \
		$(use_enable debug lock-checks) \
		$(use_enable debug alloc-checks) \
		$(use_enable static static-exe) \
		$(use_with libevent) \
		$(use_with threads pthreads) \
		$(use_with python pyunbound) \
		$(use_with python pythonmodule) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}/unbound.initd" unbound || die "newinitd failed"
	newconfd "${FILESDIR}/unbound.confd" unbound || die "newconfd failed"

	dodoc doc/{README,CREDITS,TODO,Changelog,FEATURES} || die "dodoc failed"

	exeinto /usr/share/${PN}
	doexe contrib/{update-anchor,update-itar,split-itar}.sh || die "doexe failed"
}
