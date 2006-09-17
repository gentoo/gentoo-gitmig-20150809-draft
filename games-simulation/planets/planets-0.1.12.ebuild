# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/planets/planets-0.1.12.ebuild,v 1.1 2006/09/17 10:47:40 tupone Exp $

inherit eutils games

DESCRIPTION="a simple interactive planetary system simulator"
SRC_URI="http://planets.homedns.org/dist/${P}.tgz"
HOMEPAGE="http://planets.homedns.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/tcl
	dev-lang/tk"
DEPEND="${RDEPEND}
	dev-lang/ocaml"

pkg_setup() {
	# response to bug #134257
	if ! built_with_use dev-lang/ocaml tcltk ; then
		eerror "${PN} doesn't build properly if"
		eerror "dev-lang/ocaml is built without tcltk support."
		die "Please emerge dev-lang/ocaml with USE=tcltk"
	fi
	games_pkg_setup
}

src_compile() {
	make clean
	make planets || die "make failed"
}

src_install() {
	dogamesbin planets || die "dogamesbin failed"
	doman planets.1
	dodoc CREDITS CHANGES TODO KEYBINDINGS.txt README
	prepgamesdirs
}
