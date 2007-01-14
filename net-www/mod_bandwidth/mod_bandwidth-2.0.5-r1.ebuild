# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bandwidth/mod_bandwidth-2.0.5-r1.ebuild,v 1.6 2007/01/14 01:59:02 chtekk Exp $

inherit apache-module

DESCRIPTION="Bandwidth Management Module for Apache1."
HOMEPAGE="http://www.cohprog.com/v3/bandwidth/intro-en.html"
SRC_URI="ftp://ftp.cohprog.com/pub/apache/module/1.3.0/${PN}.c"

KEYWORDS="~amd64 ppc ~sparc x86"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="BANDWIDTH"

need_apache1

src_unpack() {
	cp -f "${DISTDIR}/${PN}.c" "${S}/" || die "source copy failed"
}

pkg_postinst() {
	install -m0755 -o apache -g apache -d "${ROOT}"/var/cache/${PN}/{link,master}
	apache1_pkg_postinst
}
