# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/orpie/orpie-1.4.3-r1.ebuild,v 1.3 2008/02/15 11:35:33 markusle Exp $

inherit flag-o-matic

DESCRIPTION="A fullscreen RPN calculator for the console"
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/orpie/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/orpie/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bindist"

DEPEND="dev-lang/ocaml
	sys-libs/ncurses
	!bindist? ( sci-libs/gsl )
	bindist? ( <sci-libs/gsl-1.10 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-quote-down-crash.patch
	epatch "${FILESDIR}"/${PN}-ocaml-gentoo.patch
}

src_install() {
	make install DESTDIR="${D}"
	dodoc ChangeLog
	dodoc doc/TODO
	insinto /usr/share/doc/${PF}
	doins doc/manual.pdf
	doins doc/manual.html
}
