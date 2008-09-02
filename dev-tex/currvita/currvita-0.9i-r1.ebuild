# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/currvita/currvita-0.9i-r1.ebuild,v 1.2 2008/09/02 12:50:21 aballier Exp $

inherit latex-package

DESCRIPTION="A LaTeX package for typesetting a curriculum vitae"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/currvita/"
# snapshot taken from
# ftp://ftp.dante.de/tex-archive/macros/latex/contrib/currvita.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

IUSE=""

# >=tetex-2 includes currvita
DEPEND="!>=app-text/tetex-2
	!app-text/ptex"

S="${WORKDIR}/${PN}"

TEXMF="/usr/share/texmf-site"
DOCS="README"

src_test() {
	latex currvita.dtx || die "first step of currvita.dtx failed"
	latex currvita.dtx || die "second step of currvita.dtx failed"
	latex currvita.dtx || die "third step of currvita.dtx failed"
	latex cvtest.tex || die "processing cvtest.tex failed"
}
