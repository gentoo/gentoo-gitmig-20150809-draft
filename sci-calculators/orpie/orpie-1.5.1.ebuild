# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/orpie/orpie-1.5.1.ebuild,v 1.1 2008/01/05 16:28:54 bicatali Exp $

DESCRIPTION="A fullscreen RPN calculator for the console"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/orpie/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/orpie/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/ocaml
	sci-libs/gsl
	sys-libs/ncurses"

src_install() {
	emake  DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog doc/TODO || die
	insinto /usr/share/doc/${PF}
	doins doc/manual.pdf doc/manual.html || die
}
