# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latexdiff/latexdiff-0.2.ebuild,v 1.1 2004/11/07 07:50:59 usata Exp $

DESCRIPTION="latexdiff compares two latex files and marks up significant differences between them"

HOMEPAGE="http://www.ctan.org/tex-archive/support/latexdiff/"

# Taken from: http://www.ctan.org/tex-archive/support/latexdiff/
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-lang/perl-5.8.4-r1
	>=dev-perl/Algorithm-Diff-1.15"


src_install() {
	dodoc CHANGES LICENSE README
	insinto /usr/share/doc/${P}
	doins latexdiff-man.pdf

	dobin latexdiff latexrevise
	doman latexdiff.1 latexrevise.1
}

