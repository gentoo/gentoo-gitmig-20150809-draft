# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_lisp/mod_lisp-2.33.ebuild,v 1.2 2004/10/18 15:22:51 mkennedy Exp $

DESCRIPTION="mod_lisp is an Apache module to easily write web applications in Common Lisp"
HOMEPAGE="http://www.fractalconcept.com/asp/sdataQIceRsMvtN9fDM==/sdataQuvY9x3g$ecX"
SRC_URI="http://www.fractalconcept.com/fcweb/download/${P}.c"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="=net-www/apache-1*"

S=${WORKDIR}/${P}

src_unpack() {
	mkdir ${S}
	cp ${DISTDIR}/${P}.c ${S}/${PN}.c
}

src_compile() {
	apxs -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe *.so
	dodoc ${FILESDIR}/README.Gentoo
	docinto examples
	dodoc ${FILESDIR}/apache.conf
}
