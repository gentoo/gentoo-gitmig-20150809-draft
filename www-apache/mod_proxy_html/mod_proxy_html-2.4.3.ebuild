# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_proxy_html/mod_proxy_html-2.4.3.ebuild,v 1.6 2007/01/15 18:37:36 chtekk Exp $

inherit apache-module

KEYWORDS="x86"

DESCRIPTION="An Apache2 module to rewrite links in html pages behind a reverse proxy."
HOMEPAGE="http://apache.webthing.com/mod_proxy_html/"
SRC_URI="mirror://gentoo/${P}.c"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="PROXY_HTML"

need_apache2

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}

src_compile() {
	APXS2_ARGS="$(xml2-config --cflags) -c ${PN}.c"
	apache2_src_compile
}
