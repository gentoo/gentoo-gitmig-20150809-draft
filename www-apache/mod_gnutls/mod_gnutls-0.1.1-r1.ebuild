# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_gnutls/mod_gnutls-0.1.1-r1.ebuild,v 1.5 2005/04/15 06:21:02 trapni Exp $

inherit apache-module ssl-cert

DESCRIPTION="mod_gnutls uses the GnuTLS library to provide SSL v3, TLS 1.0 and \
TLS 1.1 encryption for Apache HTTPD. It is similar to mod_ssl in purpose, but \
does not use OpenSSL."
SRC_URI="http://www.outoforder.cc/downloads/mod_gnutls/${P}.tar.bz2"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_gnutls/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND=">=net-libs/gnutls-1.2.0"

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="GNUTLS"

DOCFILES="LICENSE NOTICE README"

need_apache2

src_compile() {
	econf --with-apxs="${APXS2}" || die "configure failed"

	emake || die "make failed"
}

src_install() {
	mv src/.libs/{lib,}mod_gnutls.so

	insinto ${APACHE2_CONFDIR}
	doins data/rsafile data/dhfile

	keepdir ${APACHE2_CONFDIR}/ssl
	keepdir /var/cache/mod_gnutls

	apache-module_src_install
}

#pkg_postinst() {
#	if [ ! -f "${APACHE2_CONFDIR}/ssl/server.crt" ]; then
#		docert "${APACHE2_CONFDIR}/ssl/server"
#	else
#		einfo "Skipping generation of SSL server certificates,"
#		einfo "as it seem you already have some."
#	fi
#}

# vim:ts=4
