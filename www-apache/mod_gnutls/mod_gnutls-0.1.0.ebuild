# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_gnutls/mod_gnutls-0.1.0.ebuild,v 1.1 2005/04/08 22:47:39 trapni Exp $

inherit apache-module

DESCRIPTION="mod_gnutls uses the GnuTLS library to provide SSL v3, TLS 1.0 and \
TLS 1.1 encryption for Apache HTTPD. It is similar to mod_ssl in purpose, but \
does not use OpenSSL."
SRC_URI="http://www.outoforder.cc/downloads/mod_gnutls/${P}.tar.bz2"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_gnutls/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=net-libs/gnutls-1.2.0"

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="GNUTLS"

DOCFILES="LICENSE NOTICE README"

need_apache2

src_compile() {
	./autogen.sh || die "couldn't create autotool files"

	econf --with-apxs=/usr/sbin/apxs2 || die "configure failed"

	emake || die "make failed"
}

src_install() {
	mv src/.libs/{lib,}mod_gnutls.so
	apache-module_src_install
}

# vim:ts=4
