# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_loadavg/mod_loadavg-0.0.1.ebuild,v 1.1 2007/09/08 18:04:58 hollow Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Apache module executing CGI-Requests depending on the load of the server"
HOMEPAGE="http://defunced.de/"
SRC_URI="mirror://gentoo/${P}.c"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="LOADAVG"

need_apache2

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}
