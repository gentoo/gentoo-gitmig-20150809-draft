# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_proxy_html/mod_proxy_html-3.0.0.ebuild,v 1.1 2007/09/08 17:53:50 hollow Exp $

inherit apache-module

KEYWORDS="~amd64 ~x86"

DESCRIPTION="An Apache2 module to rewrite links in html pages behind a reverse proxy."
HOMEPAGE="http://apache.webthing.com/mod_proxy_html/"
SRC_URI="mirror://gentoo/${P}.c.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="app-arch/bzip2
		dev-libs/libxml2"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="PROXY_HTML"

need_apache2

S="${WORKDIR}/${PN}"

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	bzip2 -dc "${DISTDIR}/${P}.c.bz2" > "${S}/${PN}.c" || die "source unpack failed"
}

src_compile() {
	APXS2_ARGS="$(xml2-config --cflags) -c ${PN}.c"
	apache2_src_compile
}
