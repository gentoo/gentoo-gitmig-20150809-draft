# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kannel/kannel-1.4.0.ebuild,v 1.1 2005/05/16 22:05:25 mrness Exp $
inherit eutils

DESCRIPTION="Powerful SMS and WAP gateway"
HOMEPAGE="http://www.kannel.org/"
SRC_URI="http://www.kannel.org/download/${PV}/gateway-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl mysql sqlite postgres pcre doc debug pam"

RDEPEND="virtual/libc
	>=dev-libs/libxml2-2.6.17
	>=dev-lang/perl-5.8.5
	>=sys-libs/zlib-1.2.2
	ssl? ( >=dev-libs/openssl-0.9.7d )
	mysql? ( >=dev-db/mysql-4.0.22 )
	sqlite? ( dev-db/sqlite )
	postgres? ( dev-db/postgresql )
	pcre? ( dev-libs/libpcre )
	doc? ( media-gfx/transfig
		app-text/jadetex
		app-text/docbook-dsssl-stylesheets )
	pam? ( >=sys-libs/pam-0.77 )"
DEPEND="${RDEPEND}
	>=sys-devel/bison-1.875d"

S=${WORKDIR}/gateway-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	#by default, use current directory for logging
	sed -i -e 's:/tmp/::' doc/examples/kannel.conf
	#correct doc path
	sed -i -e "s:share/doc/kannel:share/doc/${PF}:" configure configure.in
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
		$(use_with postgres pgsql) \
		|| die "./configure failed"

	emake || die "emake failed"
}

pkg_preinst() {
	enewgroup kannel
	enewuser kannel -1 /bin/false /var/log/kannel kannel
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	use doc && make DESTDIR=${D} install-docs
	dodoc README LICENSE

	diropts -g kannel -m0750
	dodir /etc/kannel
	insinto /etc/kannel
	newins doc/examples/kannel.conf kannel.conf.sample
	newins doc/examples/modems.conf modems.conf.sample
	use mysql && newins doc/examples/dlr-mysql.conf dlr-mysql.conf.sample

	diropts -g kannel -m0770
	keepdir /var/log/kannel

	exeinto /etc/init.d
	newexe ${FILESDIR}/kannel-initd kannel
	insinto /etc/conf.d
	newins ${FILESDIR}/kannel-confd kannel
}

src_test() {
	make check || die "make check failed"
}
