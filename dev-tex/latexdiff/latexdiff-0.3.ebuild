# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latexdiff/latexdiff-0.3.ebuild,v 1.2 2007/07/13 06:20:20 mr_bones_ Exp $

DESCRIPTION="Compare two latex files and mark up significant differences"
HOMEPAGE="http://www.ctan.org/tex-archive/support/latexdiff/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="static"

DEPEND=">=dev-lang/perl-5.8
	!static? ( dev-perl/Algorithm-Diff )"

src_install() {
	dodoc CHANGES LICENSE README
	dodoc latexdiff-man.pdf

	if use static ; then
		newbin latexdiff-so latexdiff
	else
		dobin latexdiff
	fi
	dobin latexrevise latexdiff-cvs
	doman latexdiff.1 latexrevise.1 latexdiff-cvs.1
}
