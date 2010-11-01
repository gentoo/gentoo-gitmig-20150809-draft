# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latexdiff/latexdiff-0.5.ebuild,v 1.9 2010/11/01 22:14:06 maekke Exp $

DESCRIPTION="Compare two latex files and mark up significant differences"
HOMEPAGE="http://www.ctan.org/tex-archive/support/latexdiff/"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa x86 ~amd64-linux ~x86-linux ~x86-macos"

IUSE=""

RDEPEND=">=dev-lang/perl-5.8
	dev-perl/Algorithm-Diff"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_test() {
	emake test-ext || die "Tests failed!"
}

src_install() {
	dobin latexdiff latexrevise latexdiff-vc || die "dobin failed"
	doman latexdiff.1 latexrevise.1 latexdiff-vc.1 || die "doman failed"
	dodoc CHANGES README latexdiff-man.pdf || die "dodoc failed"
}
