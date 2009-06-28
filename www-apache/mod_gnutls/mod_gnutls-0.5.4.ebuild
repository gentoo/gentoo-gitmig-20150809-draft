# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_gnutls/mod_gnutls-0.5.4.ebuild,v 1.3 2009/06/28 17:46:13 hollow Exp $

EAPI="2"

inherit apache-module eutils ssl-cert

DESCRIPTION="mod_gnutls uses GnuTLS to provide SSL/TLS encryption for Apache2, similarly to mod_ssl"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_gnutls/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

DEPEND=">=net-libs/gnutls-2.4.0"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="GNUTLS"

DOCFILES="NEWS NOTICE README README.ENV"

need_apache2

src_prepare() {
	epatch "${FILESDIR}/${P}-apache-2.4.patch"
}

src_configure() {
	econf --with-apxs="${APXS}"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	mv -f src/.libs/libmod_gnutls.so src/.libs/${PN}.so
	keepdir /var/cache/${PN}
	apache-module_src_install
}
