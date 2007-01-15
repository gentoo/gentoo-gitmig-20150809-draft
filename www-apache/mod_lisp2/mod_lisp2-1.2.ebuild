# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_lisp2/mod_lisp2-1.2.ebuild,v 1.3 2007/01/15 17:10:11 chtekk Exp $

inherit apache-module eutils

KEYWORDS="~x86"

DESCRIPTION="mod_lisp2 is an Apache2 module to easily write web applications in Common Lisp."
HOMEPAGE="http://www.fractalconcept.com/asp/sdataQIceRsMvtN9fDM==/sdataQuvY9x3g$ecX"
SRC_URI="mirror://gentoo/${P}.c"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="LISP"

need_apache2

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"

	cd "${S}"
	epatch "${FILESDIR}/${PV}-content-length.patch"
}
