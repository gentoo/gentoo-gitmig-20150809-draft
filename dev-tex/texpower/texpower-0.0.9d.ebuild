# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/texpower/texpower-0.0.9d.ebuild,v 1.1 2003/09/15 18:45:54 pylon Exp $

inherit latex-package


IUSE="doc"

S=${WORKDIR}/${P}
TD=texpower-doc-pdf-${PV}

DESCRIPTION="A bundle of style and class files for creating dynamic online presentations."
SRC_URI="mirror://sourceforge/texpower/${P}.tar.gz
	doc? ( mirror://sourceforge/texpower/${TD}.tar.gz )"
HOMEPAGE="http://texpower.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_install() {
	cd ${S}
	latex-package_src_install
	if use doc; then
		S=${WORKDIR}/${P}/doc
		latex-package_src_install
	fi
}
