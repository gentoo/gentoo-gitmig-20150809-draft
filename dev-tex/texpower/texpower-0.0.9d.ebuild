# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/texpower/texpower-0.0.9d.ebuild,v 1.5 2003/11/16 05:17:37 obz Exp $

inherit latex-package

IUSE="doc"

S=${WORKDIR}/${P}
TD=${PN}-doc-pdf-${PV}

DESCRIPTION="A bundle of style and class files for creating dynamic online presentations."
SRC_URI="mirror://sourceforge/texpower/${P}.tar.gz
	doc? ( mirror://sourceforge/texpower/${TD}.tar.gz )"
HOMEPAGE="http://texpower.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

src_install() {

	latex-package_src_install
	doins *.cfg

	insinto /usr/share/texmf/tex/latex/${PN}/addons
	doins addons/*.sty

	insinto /usr/share/texmf/tex/latex/${PN}/contrib
	doins contrib/config.landscapeplus contrib/tpmultiinc.tar

	dodoc 00readme.txt 01install.txt 0changes.txt
	newdoc addons/00readme.txt 00readme-addons.txt
	newdoc contrib/00readme.txt 00readme-contrib.txt

	if use doc; then
		insinto /usr/share/doc/${P}/manual
		doins doc/*.{tex,pdf,cfg}
	fi

}
