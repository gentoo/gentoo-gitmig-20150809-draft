# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/amphetamine/amphetamine-0.8.10.ebuild,v 1.1 2007/02/08 20:50:08 tupone Exp $

inherit eutils games

DESCRIPTION="a cool Jump'n Run game offering some unique visual effects."
HOMEPAGE="http://n.ethz.ch/student/loehrerl/amph/amph.html"
SRC_URI="http://n.ethz.ch/student/loehrerl/amph/files/${P}.tar.bz2
	http://n.ethz.ch/student/loehrerl/amph/files/${PN}-data-0.8.6.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl
	x11-libs/libXpm"

src_compile() {
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		Makefile
	emake || die "emake failed"
}

src_install() {
	newgamesbin amph ${PN}

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ../amph/* || die "installing data failed"

	dodoc BUGS ChangeLog NEWS README || die "Installing doc"
	newicon amph.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Amphetamine" ${PN}.xpm

	prepgamesdirs
}
