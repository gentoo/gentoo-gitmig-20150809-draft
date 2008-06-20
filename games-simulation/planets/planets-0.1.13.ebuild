# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/planets/planets-0.1.13.ebuild,v 1.2 2008/06/20 18:26:39 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="a simple interactive planetary system simulator"
HOMEPAGE="http://planets.homedns.org/"
SRC_URI="http://planets.homedns.org/dist/${P}.tgz"

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
	if ! built_with_use dev-lang/ocaml tk ; then
		eerror "${PN} doesn't build properly if"
		eerror "dev-lang/ocaml is built without tk support."
		die "Please emerge dev-lang/ocaml with USE=tk"
	fi
	games_pkg_setup
}

src_install() {
	dogamesbin planets || die "dogamesbin failed"
	doicon ${PN}.png
	domenu ${PN}.desktop
	doman ${PN}.1
	dohtml getting_started.html
	dodoc CHANGES CREDITS KEYBINDINGS.txt README TODO
	prepgamesdirs
}
