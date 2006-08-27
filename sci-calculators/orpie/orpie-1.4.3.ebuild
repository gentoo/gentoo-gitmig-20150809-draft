# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/orpie/orpie-1.4.3.ebuild,v 1.1 2006/08/27 03:21:44 markusle Exp $

inherit flag-o-matic

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

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	dodoc ChangeLog
	dodoc doc/TODO
	insinto /usr/share/doc/${PF}
	doins doc/manual.pdf
	doins doc/manual.html
}
