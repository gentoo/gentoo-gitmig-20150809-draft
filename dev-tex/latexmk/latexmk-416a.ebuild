# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latexmk/latexmk-416a.ebuild,v 1.1 2010/06/11 11:26:30 aballier Exp $

DESCRIPTION="Perl script for automatically building LaTeX documents."
HOMEPAGE="http://www.phys.psu.edu/~collins/software/latexmk/"
SRC_URI="http://www.phys.psu.edu/~collins/software/latexmk/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/latex-base
	dev-lang/perl"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_install() {
	cd "${WORKDIR}"
	newbin latexmk.pl latexmk
	dodoc CHANGES README latexmk.pdf latexmk.ps latexmk.txt
	doman latexmk.1
	insinto /usr/share/doc/${PF}
	doins -r example_rcfiles extra-scripts
}
