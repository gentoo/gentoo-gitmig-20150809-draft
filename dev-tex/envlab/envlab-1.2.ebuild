# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/envlab/envlab-1.2.ebuild,v 1.1 2004/02/28 22:10:39 usata Exp $

S="${WORKDIR}/${PN}"
LICENSE="LPPL-1.2"
DESCRIPTION="A LaTeX module to format envelopes"
HOMEPAGE="http://planck.psu.edu/~boris/"
# downloaded from
# ftp://ftp.ctan.org/pub/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
SLOT="0"
DEPEND="virtual/tetex"
KEYWORDS="~x86"

src_compile() {
	ebegin "Compiling ${PN}"
	latex envlab.ins || die
	pdflatex elguide.tex || die
	pdflatex envlab.drv || die
	eend
}

src_install() {
	ebegin "Installing ${PN}"
	dodir /usr/share/texmf/tex/latex/envlab
	cp -Rv envlab.{cfg,sty} ${D}/usr/share/texmf/tex/latex/envlab
	dodoc elguide.pdf envlab.pdf readme.v12
	eend
}

pkg_postinst() {
	ebegin "Updating LaTeX Module Index"
	texhash
	eend
}

pkg_postrm() {
	ebegin "Updating LaTeX Module Index"
	texhash
	eend
}
