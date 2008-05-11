# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/currvita/currvita-0.9i.ebuild,v 1.8 2008/05/11 21:32:50 aballier Exp $

inherit latex-package

DESCRIPTION="A LaTeX package for typesetting a curriculum vitae"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/currvita/"
# snapshot taken from
# ftp://ftp.dante.de/tex-archive/macros/latex/contrib/currvita.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

IUSE=""

# >=tetex-2 includes currvita
DEPEND="!>=app-text/tetex-2
	!app-text/ptex
	virtual/tetex"

S="${WORKDIR}/${PN}"

src_install() {

	latex-package_src_install

	dodoc README
}

src_test() {

	latex currvita.dtx || die "first step of currvita.dtx failed"
	latex currvita.dtx || die "second step of currvita.dtx failed"
	latex currvita.dtx || die "third step of currvita.dtx failed"
	latex cvtest.tex || die "processing cvtest.tex failed"
}
