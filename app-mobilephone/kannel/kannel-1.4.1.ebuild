# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kannel/kannel-1.4.1.ebuild,v 1.11 2010/06/17 21:26:13 patrick Exp $

WANT_AUTOMAKE=none

inherit eutils autotools flag-o-matic

DESCRIPTION="Powerful SMS and WAP gateway"
HOMEPAGE="http://www.kannel.org/"
SRC_URI="http://www.kannel.org/download/${PV}/gateway-${PV}.tar.gz"

LICENSE="Kannel"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="ssl mysql sqlite sqlite3 postgres pcre doc debug pam"

RDEPEND=">=dev-libs/libxml2-2.6.26
	>=dev-lang/perl-5.8.8
	>=sys-libs/zlib-1.2.3
	ssl? ( >=dev-libs/openssl-0.9.8d )
	mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-2* )
	sqlite3? ( >=dev-db/sqlite-3.2.1 )
	postgres? ( dev-db/postgresql-server )
	pcre? ( dev-libs/libpcre )
	doc? ( media-gfx/transfig
		app-text/jadetex
		app-text/docbook-dsssl-stylesheets )
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	>=sys-devel/bison-2.2"

S="${WORKDIR}/gateway-${PV}"

pkg_setup() {
	enewgroup kannel
	enewuser kannel -1 -1 /var/log/kannel kannel
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-custom-wap-ports.patch"
	epatch "${FILESDIR}/${P}-nolex.patch" # flex is not used

	#by default, use current directory for logging
	sed -i -e 's:/tmp/::' doc/examples/kannel.conf

	eautoconf
}

src_compile() {
	append-flags -fno-strict-aliasing # some code breaks strict aliasing
	econf --docdir=/usr/share/doc/${P} \
		--enable-localtime \
		--disable-start-stop-daemon \
		$(use_enable pam) \
		$(use_enable debug debug) \
		$(use_enable pcre) \
		$(use_enable doc docs) \
		$(use_enable ssl) \
		$(use_with mysql) \
		$(use_with sqlite) \
		$(use_with sqlite3) \
		$(use_with postgres pgsql) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_test() {
	emake check || die "make check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		emake DESTDIR="${D}" install-docs || die "emake install-docs failed"
	fi
	dodoc README

	diropts -g kannel -m0750
	dodir /etc/kannel
	insinto /etc/kannel
	newins doc/examples/kannel.conf kannel.conf.sample
	newins doc/examples/modems.conf modems.conf.sample
	use mysql && newins doc/examples/dlr-mysql.conf dlr-mysql.conf.sample

	diropts -g kannel -m0770
	keepdir /var/log/kannel

	newinitd "${FILESDIR}/kannel-initd" kannel
	newconfd "${FILESDIR}/kannel-confd" kannel
}
