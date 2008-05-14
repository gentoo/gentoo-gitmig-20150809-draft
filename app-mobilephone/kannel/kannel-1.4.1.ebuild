# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kannel/kannel-1.4.1.ebuild,v 1.6 2008/05/14 21:59:26 flameeyes Exp $
inherit eutils

DESCRIPTION="Powerful SMS and WAP gateway"
HOMEPAGE="http://www.kannel.org/"
SRC_URI="http://www.kannel.org/download/${PV}/gateway-${PV}.tar.gz"

LICENSE="BSD"
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
	postgres? ( dev-db/postgresql )
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

	epatch "${FILESDIR}/${P}-custom-wap-ports.patch"

	cd "${S}"
	#by default, use current directory for logging
	sed -i -e 's:/tmp/::' doc/examples/kannel.conf
	#correct doc path
	sed -i -e "s:share/doc/kannel:share/doc/${P}:" configure configure.in
}

src_compile() {
	econf \
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
		|| die "./configure failed"

	emake || die "emake failed"
}

src_test() {
	make check || die "make check failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	use doc && make DESTDIR="${D}" install-docs
	dodoc README LICENSE

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
