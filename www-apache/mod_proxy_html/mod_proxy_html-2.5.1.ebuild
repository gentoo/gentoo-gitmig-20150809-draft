# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_proxy_html/mod_proxy_html-2.5.1.ebuild,v 1.3 2006/07/10 15:16:35 blubb Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO to rewrite links in html pages behind a reverse proxy"
HOMEPAGE="http://apache.webthing.com/mod_proxy_html/"
SRC_URI="mirror://gentoo/${P}.c.bz2"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="app-arch/bzip2"
RDEPEND="${DEPEND}
	dev-libs/libxml2"

S="${WORKDIR}"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="PROXY_HTML"

need_apache2

src_unpack() {
	bzip2 -dc "${DISTDIR}/${P}.c.bz2" > "${PN}.c" || die
}

src_compile() {
	APXS2_ARGS="$(xml2-config --cflags) -c ${PN}.c"
	apache2_src_compile
}
