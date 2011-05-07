# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/unbound/unbound-1.4.8.ebuild,v 1.2 2011/05/07 17:03:23 tomka Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"
inherit eutils python

DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"
SRC_URI="http://unbound.net/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86 ~x64-macos"
IUSE="debug gost python static-libs test threads"

RDEPEND="dev-libs/expat
	dev-libs/libevent
	>=dev-libs/openssl-0.9.8
	>=net-libs/ldns-1.6.5[ssl,gost?]"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	test? (
		net-dns/ldns-utils[examples]
		dev-util/splint
		app-text/wdiff
	)"

# bug #347415
RDEPEND="${RDEPEND}
	net-dns/dnssec-root"

pkg_setup() {
	python_set_active_version 2
	enewgroup unbound
	enewuser unbound -1 -1 /etc/unbound unbound
}

src_configure() {
	econf \
		--with-pidfile="${EPREFIX}"/var/run/unbound.pid \
		--with-ldns="${EPREFIX}"/usr \
		--with-libevent="${EPREFIX}"/usr \
		--with-rootkey-file="${EPREFIX}"/etc/dnssec/root-anchors.txt \
		$(use_enable debug) \
		$(use_enable debug lock-checks) \
		$(use_enable debug alloc-checks) \
		$(use_enable debug alloc-lite) \
		$(use_enable debug alloc-nonregional) \
		$(use_enable gost) \
		$(use_enable static-libs static) \
		$(use_with threads pthreads) \
		$(use_with python pyunbound) \
		$(use_with python pythonmodule) \
		--disable-rpath || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# bug #299016
	if use python ; then
		find "${ED}$(python_get_sitedir)" "(" -name "*.a" -o -name "*.la" ")" -type f -delete || die
	fi

	newinitd "${FILESDIR}/unbound.initd" unbound || die "newinitd failed"
	newconfd "${FILESDIR}/unbound.confd" unbound || die "newconfd failed"

	dodoc doc/{README,CREDITS,TODO,Changelog,FEATURES} || die "dodoc failed"

	# bug #315519
	#exeinto /usr/libexec/munin/plugins
	#doexe contrib/unbound_munin_ || die "doexe failed"
	dodoc contrib/unbound_munin_ || die "dodoc failed"

	docinto selinux
	dodoc contrib/selinux/* || die "dodoc failed"

	exeinto /usr/share/${PN}
	doexe contrib/update-anchor.sh || die "doexe failed"
}
