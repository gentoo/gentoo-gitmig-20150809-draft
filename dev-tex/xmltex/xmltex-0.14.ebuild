# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/xmltex/xmltex-0.14.ebuild,v 1.1 2004/02/01 13:53:55 usata Exp $

inherit latex-package

IUSE=""

DESCRIPTION="A non validating namespace aware XML parser implemented in TeX"
HOMEPAGE="http://www.dcarlisle.demon.co.uk/xmltex/manual.html"
# Taken from: ftp://www.ctan.org/tex-archive/macros/xmltex.tar.gz
SRC_URI="http://ftp.debian.org/debian/pool/main/x/xmltex/${P/-/_}.orig.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/tetex"

S=${WORKDIR}/${PN}/base

src_compile() {

	tex -ini -progname=xmltex "&latex" xmltex.ini || die
	pdftex -ini -progname=pdfxmltex "&pdflatex" pdfxmltex.ini || die
}

src_install() {

	insinto ${TEXMF}/web2c
	doins *.fmt || die

	if ! grep pdfxmltex ${TEXMF}/web2c/texmf.cnf > /dev/null 2>&1 ; then
		cp ${TEXMF}/web2c/texmf.cnf ${T}
		cat >>${T}/texmf.cnf<<-EOF

		! Automatically added by Portage (dev-tex/xmltex)
		TEXINPUTS.pdfxmltex = .;\$TEXMF/{pdftex,tex}/{xmltex,plain,generic,}//
		EOF
		doins ${T}/texmf.cnf
	fi

	insinto ${TEXMF}/tex/xmltex
	doins *.{xml,xmt,,cfg,tex,ini}

	dodir /usr/bin
	dosym /usr/bin/tex /usr/bin/xmltex
	dosym /usr/bin/pdftex /usr/bin/pdfxmltex

	dohtml *.html
	dodoc readme.txt
}
