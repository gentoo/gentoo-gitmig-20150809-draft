# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/cweb_latex/cweb_latex-1.1.1.ebuild,v 1.3 2004/04/17 16:36:26 aliz Exp $

PATCHES="${FILESDIR}/cweb.cls.patch"
inherit latex-package

DESCRIPTION="LaTeX package for using LaTeX with CWEB"
SRC_URI="ftp://ftp.th-darmstadt.de//programming/literate-programming/c.c++/cweb-sty-${PV}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 mips"

S="${WORKDIR}/cweb-sty-${PV}"

src_install() {
	latex-package_src_install
	# this package has a .tex file which needs to go with the cweb.sty
	insinto ${TEXMF}/tex/latex/${PN}
	doins cwebbase.tex
}
