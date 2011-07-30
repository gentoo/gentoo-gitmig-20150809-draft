# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/frobtads/frobtads-1.0.ebuild,v 1.2 2011/07/30 17:11:15 mr_bones_ Exp $

EAPI=2
inherit flag-o-matic games

DESCRIPTION="Curses-based interpreter and development tools for TADS 2 and TADS 3 text adventures"
HOMEPAGE="http://www.tads.org/frobtads.htm"
SRC_URI="http://www.tads.org/frobtads/${P}.tar.gz
	tads2compiler? ( http://www.tads.org/frobtads/${PN}-t2compiler-${PV}.tar.gz )
	tads3compiler? ( http://www.tads.org/frobtads/${PN}-t3compiler-${PV}.tar.gz )"

LICENSE="TADS2 TADS3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug tads2compiler tads3compiler"

RESTRICT="!tads3compiler? ( test )"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	if use tads2compiler; then
		mv t2compiler/* "${S}"/t2compiler || die "mv t2compiler failed"
	fi
	if use tads3compiler; then
		mv t3compiler/* "${S}"/t3compiler || die "mv t3compiler failed"
	fi
}

src_configure() {
	append-cxxflags -fno-strict-aliasing -fpermissive
	egamesconf $(use_enable debug t3debug) || die "egamesconf failed"
}

src_test() {
	if use debug; then
		emake -j1 check || die "TADS 3 compiler test suite failed"
	fi

	emake -j1 sample || die "Failed to build test game"
	./frob -i plain -p samples/sample.t3 <<- END_FROB_TEST
		save
		testsave.sav
		restore
		testsave.sav
	END_FROB_TEST
	[[ $? -eq 0 ]] || die "Failed to run test game"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/{AUTHORS,BUGS,ChangeLog.old,NEWS,README,SRC_GUIDELINES,THANKS}
	prepgamesdirs
}
