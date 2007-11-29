# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gfceu/gfceu-0.6.0.ebuild,v 1.1 2007/11/29 20:01:19 tupone Exp $

inherit games

DESCRIPTION="GTK frontend for the FCE Ultra NES emulator"
HOMEPAGE="http://dietschnitzel.com/gfceu/"
SRC_URI="http://dietschnitzel.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="games-emulation/fceultra
	>=dev-python/pygtk-2.6
	dev-python/gnome-python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		gfceu || die "sed on gfceu failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins ${PN}.glade || die "doins failed"

	dodoc ChangeLog TODO
	doman ${PN}.1
	doicon ${PN}.png
	make_desktop_entry ${PN} "GFCE Ultra" ${PN}.png
	prepgamesdirs
}
