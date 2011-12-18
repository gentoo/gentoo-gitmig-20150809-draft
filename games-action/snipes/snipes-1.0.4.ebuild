# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/snipes/snipes-1.0.4.ebuild,v 1.4 2011/12/18 16:39:43 tupone Exp $
EAPI=2

inherit base eutils games

DESCRIPTION="2D scrolling shooter, resembles the old DOS game of same name"
HOMEPAGE="http://cyp.github.com/snipes/"
SRC_URI="http://cyp.github.com/snipes/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

PATCHES=( "${FILESDIR}"/${P}-nongnulinker.patch )

src_compile() {
	tc-getLD
	default
}

src_install() {
	dogamesbin snipes || die "dogamesbin failed"
	doman snipes.6
	dodoc ChangeLog
	doicon ${PN}.png
	make_desktop_entry snipes "Snipes"
	prepgamesdirs
}
