# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/apricots/apricots-0.2.6-r1.ebuild,v 1.4 2007/03/27 17:06:30 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="Fly a plane around bomb/shoot the enemy. Port of Planegame from Amiga."
HOMEPAGE="http://www.fishies.org.uk/apricots.html"
SRC_URI="http://www.fishies.org.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/openal
	media-libs/freealut"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freealut.patch
	sed -i \
		-e 's:-DAP_PATH=\\\\\\"$prefix.*":-DAP_PATH=\\\\\\"${GAMES_DATADIR}/${PN}/\\\\\\"":' \
		configure.in \
		|| die "sed failed"
	sed -i \
		-e "s:filename(AP_PATH):filename(\"${GAMES_SYSCONFDIR}/${PN}/\"):" \
		${PN}/init.cpp \
		|| die "sed failed"
	sed -i \
		-e "s:apricots.cfg:${GAMES_SYSCONFDIR}/${PN}/apricots.cfg:" \
		README apricots.html \
		|| die "sed failed"
	sed -i \
		-e 's/-Wmissing-prototypes//' \
		acinclude.m4 \
		|| die "sed failed"
	eautoreconf
}

src_install() {
	dodoc AUTHORS README TODO ChangeLog
	dohtml apricots.html
	cd ${PN}
	dogamesbin apricots || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins *.wav *.psf *.shapes || die "doins failed"
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins apricots.cfg || die "doins apricots.cfg failed"
	make_desktop_entry ${PN} Apricots
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "You can change the game options by editing:"
	elog "${GAMES_SYSCONFDIR}/${PN}/apricots.cfg"
}
