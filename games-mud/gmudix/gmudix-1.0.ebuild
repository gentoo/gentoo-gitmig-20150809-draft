# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gmudix/gmudix-1.0.ebuild,v 1.11 2011/03/01 07:19:18 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="GTK+ MUD client with ANSI color, macros, timers, triggers, variables, and an easy scripting language"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/gmudix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
	rm -f missing
	eautoreconf
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog README TODO doc/*txt
	prepgamesdirs
}
