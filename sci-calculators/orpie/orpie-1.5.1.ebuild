# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/orpie/orpie-1.5.1.ebuild,v 1.8 2009/02/03 14:37:55 bicatali Exp $

DESCRIPTION="A fullscreen RPN calculator for the console"
HOMEPAGE="http://pessimization.com/software/orpie/"
SRC_URI="http://pessimization.com/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc -sparc x86"
IUSE="bindist"

DEPEND="dev-lang/ocaml
	sys-libs/ncurses
	!bindist? ( sci-libs/gsl )
	bindist? ( <sci-libs/gsl-1.10 )"
RDEPEND="${DEPEND}"

src_install() {
	emake  DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog doc/TODO || die
	insinto /usr/share/doc/${PF}
	doins doc/manual.pdf doc/manual.html || die
}
