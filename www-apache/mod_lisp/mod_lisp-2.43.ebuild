# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_lisp/mod_lisp-2.43.ebuild,v 1.3 2007/01/15 17:06:04 chtekk Exp $

inherit apache-module

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DESCRIPTION="mod_lisp is an Apache1 module to easily write web applications in Common Lisp."
HOMEPAGE="http://www.fractalconcept.com/asp/sdataQIceRsMvtN9fDM==/sdataQuvY9x3g$ecX"
SRC_URI="mirror://gentoo/${P}.c"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="LISP"

need_apache1

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}
