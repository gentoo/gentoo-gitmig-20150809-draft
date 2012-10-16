# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_openid/mod_auth_openid-0.4.ebuild,v 1.2 2012/10/16 03:07:46 patrick Exp $

EAPI="2"

inherit apache-module

DESCRIPTION="An OpenID authentication module for the apache webserver"
HOMEPAGE="http://trac.butterfat.net/public/mod_auth_openid"
SRC_URI="http://butterfat.net/releases/mod_auth_openid/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/libopkele-2.0
	>=dev-db/sqlite-3"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="AUTH_OPENID"

need_apache2_2

src_configure() {
	econf --with-apxs="${APXS}" \
		--without-bdb-dir \
		--with-sqlite3=/usr \
		--with-apr-config=/usr/bin/apr-1-config \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}
