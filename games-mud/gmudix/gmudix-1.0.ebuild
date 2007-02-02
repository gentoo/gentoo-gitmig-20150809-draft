# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gmudix/gmudix-1.0.ebuild,v 1.9 2007/02/02 17:37:04 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="A GTK+ 2.0 MUD client with ANSI color mapping, aliasing, macros, paths, tab completions, timers, triggers, variables, and an easy-to-use script language and more"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/gmudix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-as-needed.patch
	rm -f missing
	eautoreconf
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog README TODO doc/*txt
	prepgamesdirs
}
