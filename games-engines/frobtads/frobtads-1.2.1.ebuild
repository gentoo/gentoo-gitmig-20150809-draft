# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/frobtads/frobtads-1.2.1.ebuild,v 1.1 2012/08/23 19:48:06 hasufell Exp $

EAPI=4
inherit autotools eutils flag-o-matic games

DESCRIPTION="Curses-based interpreter and development tools for TADS 2 and TADS 3 text adventures"
HOMEPAGE="http://www.tads.org/frobtads.htm"
SRC_URI="http://www.tads.org/frobtads/${P}.tar.gz"

LICENSE="TADS2 TADS3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug tads2compiler tads3compiler"

RESTRICT="!tads3compiler? ( test )"

RDEPEND="net-misc/curl
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

DOCS=( doc/{AUTHORS,BUGS,ChangeLog.old,NEWS,README,SRC_GUIDELINES,THANKS} )

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlinking.patch
	eautoreconf
}

src_configure() {
	append-cxxflags -fno-strict-aliasing -fpermissive
	append-cflags -fno-strict-aliasing
	egamesconf \
		--disable-silent-rules \
		$(use_enable debug t3debug) \
		$(use_enable debug error-checking) \
		$(use_enable tads2compiler t2-compiler) \
		$(use_enable tads3compiler t3-compiler)
}

src_test() {
	# FIXME: make check broken
#	if use debug; then
#		emake -j1 check
#	fi

	emake -j1 sample
	./frob -i plain -p samples/sample.t3 <<- END_FROB_TEST
		save
		testsave.sav
		restore
		testsave.sav
	END_FROB_TEST
	[[ $? -eq 0 ]] || die "Failed to run test game"
}

src_install() {
	default
	prepgamesdirs
}
