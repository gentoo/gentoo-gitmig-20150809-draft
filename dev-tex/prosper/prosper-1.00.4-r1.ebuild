# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/prosper/prosper-1.00.4-r1.ebuild,v 1.4 2004/01/05 21:32:10 aliz Exp $

inherit latex-package

DESCRIPTION="Prosper is a LaTeX class for writing transparencies"
HOMEPAGE="http://prosper.sf.net/"
SRC_URI="mirror://sourceforge/prosper/${P}.tar.gz
	mirror://sourceforge/prosper/contrib-prosper-1.0.0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
DEPEND=""
S=${WORKDIR}/${PN}

src_unpack(){
	unpack ${A}
	mv contrib-prosper-1.0.0/*.sty ${S}/contrib/
	mv contrib-prosper-1.0.0/img/* ${S}/contrib/img
}

src_install(){
	cd ${S}
	latex-package_src_doinstall styles
	insinto ${TEXMF}/tex/latex/${PN}/img/
	doins img/*.ps img/*.gif
	for i in `find ./contrib/ -maxdepth 1 -type f -name "*.sty"`
	do
		insinto ${TEXMF}/tex/latex/${PN}/contrib/
		doins $i
	done
	insinto ${TEXMF}/tex/latex/${PN}/contrib/img/
	doins ./contrib/img/*.ps
	dodoc README TODO TROUBLESHOOTINGS INSTALL NEWS FAQ AUTHORS ChangeLog
	dodoc doc/*.eps doc/*.fig doc/*.pdf doc/*.tex doc/*.ps
	docinto doc-examples/
	dodoc doc/doc-examples/*.ps doc/doc-examples/*.tex
	docinto contrib/
	dodoc contrib/*.ps contrib/*.tex
}
