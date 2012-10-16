# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_openid/mod_auth_openid-0.2-r1.ebuild,v 1.2 2012/10/16 03:07:46 patrick Exp $

inherit eutils apache-module autotools

DESCRIPTION="an OpenID authentication module for the apache webserver"
HOMEPAGE="http://trac.butterfat.net/public/mod_auth_openid"
SRC_URI="http://butterfat.net/releases/mod_auth_openid/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/apr
	net-libs/libopkele
	>=dev-db/sqlite-3"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="AUTH_OPENID"

need_apache2_2

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e '/^ACLOCAL_AMFLAGS=/d' Makefile.am

	AT_M4DIR="acinclude.d"
	eautoreconf
}

src_compile() {
	econf --with-apxs="${APXS}" \
		--without-bdb-dir \
		--with-sqlite3=/usr \
		--with-apr-config=/usr/bin/apr-1-config \
		|| die "econf failed"
	emake || die "emake failed"
}
