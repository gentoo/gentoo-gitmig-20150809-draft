# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/feynmf/feynmf-1.08.ebuild,v 1.2 2004/10/17 09:27:00 dholm Exp $

inherit eutils latex-package

DESCRIPTION="Combined LaTeX/Metafont package for drawing of Feynman diagrams"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/feynmf/"
#Taken from: ftp.tug.ctan.org/tex-archive/macros/latex/contrib/${PN}.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/tetex"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	addwrite /var/cache/fonts
	emake MP=mpost all manual.ps || die "emake failed"
}

src_install() {
	newbin feynmf.pl feynmf
	doman feynmf.1
	insinto ${TEXMF}/tex/latex/${PN}; doins feynmf.sty feynmp.sty
	insinto ${TEXMF}/metafont/${PN}; doins feynmf.mf
	insinto ${TEXMF}/metapost/${PN}; doins feynmp.mp
	dodoc README manual.ps template.tex
}
