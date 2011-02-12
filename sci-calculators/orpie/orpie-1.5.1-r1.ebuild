# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/orpie/orpie-1.5.1-r1.ebuild,v 1.5 2011/02/12 16:03:49 xarthisius Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="A fullscreen RPN calculator for the console"
HOMEPAGE="http://pessimization.com/software/orpie/"
SRC_URI="http://pessimization.com/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

DEPEND="dev-ml/ocamlgsl
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ocaml311.patch
	epatch "${FILESDIR}"/${P}-nogsl.patch
	epatch "${FILESDIR}"/${P}-orpierc.patch
	eautoreconf
}

src_install() {
	emake  DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog doc/TODO
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/manual.pdf doc/manual.html
	fi
}
