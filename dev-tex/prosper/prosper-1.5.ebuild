# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/prosper/prosper-1.5.ebuild,v 1.1 2004/09/08 17:57:28 usata Exp $

inherit latex-package

DESCRIPTION="Prosper is a LaTeX class for writing transparencies"
HOMEPAGE="http://prosper.sf.net/"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LPPL-1.2"	# has been changed since 1.5
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
DEPEND="virtual/tetex"
S=${WORKDIR}/${PN}
IUSE=""

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
