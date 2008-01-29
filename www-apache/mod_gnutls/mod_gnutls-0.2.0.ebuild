# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_gnutls/mod_gnutls-0.2.0.ebuild,v 1.6 2008/01/29 16:34:01 hollow Exp $

inherit apache-module ssl-cert

KEYWORDS="amd64 ~sparc ~x86"

DESCRIPTION="mod_gnutls uses GnuTLS to provide SSL/TLS encryption for Apache2, similarly to mod_ssl"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_gnutls/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=">=net-libs/gnutls-1.2.0"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="GNUTLS"

DOCFILES="LICENSE NOTICE README"

need_apache2

src_compile() {
	econf --with-apxs=${APXS} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	mv -f "src/.libs/libmod_gnutls.so" "src/.libs/${PN}.so"

	insinto "${APACHE_CONFDIR}"
	doins data/rsafile data/dhfile

	keepdir "${APACHE_CONFDIR}/ssl"
	keepdir /var/cache/${PN}

	apache-module_src_install
}
