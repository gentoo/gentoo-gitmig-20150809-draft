# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Id: koma-script-20040111-r1.ebuild,v 1.1 2004/02/19 17:09:28 usata Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX package with german adaptions of common (english) classes"
# Taken from: ftp://ftp.dante.de/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/koma-script.html"
LICENSE="LPPL-1.2"
#for License details see /usr/share/doc/latex-foiltex-2.1.3/foiltex.ins
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	make -f Makefile.unx || die
}

src_install () {
	dodir /usr/share/doc/${PF}
	yes | make -f Makefile.unx \
		INSTALLTEXMF=${D}/usr/share/texmf \
		DOCDIR=${D}/usr/share/doc/${PF} \
		TEXHASH="" install || die
	#dodoc 00* *.TXT *.txt
	#insinto /usr/share/doc/${PF}
	#doins *.xml *.pdf
}
