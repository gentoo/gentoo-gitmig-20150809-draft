# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bandwidth/mod_bandwidth-2.0.5-r1.ebuild,v 1.8 2007/01/15 17:02:29 chtekk Exp $

inherit apache-module

KEYWORDS="~amd64 ppc ~sparc x86"

DESCRIPTION="Bandwidth Management Module for Apache1."
HOMEPAGE="http://www.cohprog.com/v3/bandwidth/intro-en.html"
SRC_URI="ftp://ftp.cohprog.com/pub/apache/module/1.3.0/${PN}.c"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="BANDWIDTH"

need_apache1

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${PN}.c" "${S}/${PN}.c" || die "source copy failed"
}

pkg_postinst() {
	install -d -m0755 -o apache -g apache "${ROOT}"/var/cache/${PN}/{link,master}
	apache1_pkg_postinst
}
