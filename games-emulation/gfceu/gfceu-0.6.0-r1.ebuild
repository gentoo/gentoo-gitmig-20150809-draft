# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gfceu/gfceu-0.6.0-r1.ebuild,v 1.2 2009/09/29 05:50:03 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="GTK frontend for the FCE Ultra NES emulator"
HOMEPAGE="http://dietschnitzel.com/gfceu/"
SRC_URI="http://dietschnitzel.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="games-emulation/fceultra
	>=dev-python/pygtk-2.6
	dev-python/gnome-python"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}:" \
		gfceu || die "sed on gfceu failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins ${PN}.glade *.png || die "doins failed"
	dodoc ChangeLog TODO
	doman ${PN}.1
	doicon ${PN}.png
	make_desktop_entry ${PN} "GFCE Ultra" ${PN}
	prepgamesdirs
}
