# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_lisp2/mod_lisp2-1.2.ebuild,v 1.1 2005/12/30 21:04:25 mkennedy Exp $

inherit apache-module eutils

DESCRIPTION="mod_lisp is an Apache module to easily write web applications in Common Lisp"
HOMEPAGE="http://www.fractalconcept.com/asp/sdataQIceRsMvtN9fDM==/sdataQuvY9x3g$ecX"
SRC_URI="mirror://gentoo/${P}.c"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="LISP"

need_apache2

src_unpack() {
	mkdir ${S}
	cd ${S}
	cp ${DISTDIR}/${P}.c ${PN}.c
	epatch ${FILESDIR}/${PV}-content-length.patch || die # http://common-lisp.net/pipermail/mod-lisp-devel/2005-December/000082.html
}
