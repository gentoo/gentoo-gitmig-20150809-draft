# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latexmk/latexmk-307a.ebuild,v 1.1 2005/11/18 18:14:55 sebastian Exp $

DESCRIPTION="Perl script for automatically building LaTeX documents."
HOMEPAGE="http://www.phys.psu.edu/~collins/software/latexmk/"
SRC_URI="http://www.phys.psu.edu/~collins/software/latexmk/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/tetex
	dev-lang/perl"

src_install() {
	cd ${WORKDIR}
	newbin latexmk.pl latexmk
	dodoc CHANGES INSTALL README latexmk.pdf latexmk.ps latexmk.txt
	doman latexmk.1
}
