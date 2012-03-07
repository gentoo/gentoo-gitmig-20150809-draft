# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/cs2d/cs2d-0120.ebuild,v 1.1 2012/03/07 21:28:29 maksbotan Exp $

EAPI=2

inherit eutils games

DESCRIPTION="Counter-Strike 2D is freeware clone of Counter-Strike with some added features in gameplay."
HOMEPAGE="http://www.cs2d.com/"
SRC_URI="http://dev.gentoo.org/~maksbotan/cs2d/cs2d_${PV}_linux.zip
	http://dev.gentoo.org/~maksbotan/cs2d/cs2d_${PV}_win.zip"
LICENSE="freedist"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="x86? (
		media-libs/openal )
	amd64? (
		app-emulation/emul-linux-x86-sdl
	)"

QA_PRESTRIPPED="opt/cs2d/CounterStrike2D"
QA_EXECSTACK="opt/cs2d/CounterStrike2D"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	# removing windows files
	rm -f *.exe *.bat
}

src_install() {
	insinto "${GAMES_PREFIX_OPT}/${PN}"
	doins -r . || die

	doicon "${FILESDIR}/cs2d.png"

	make_desktop_entry CounterStrike2D "Counter Strike 2D"
	make_desktop_entry "CounterStrike2D -fullscreen -24bit" "Counter Strike 2D - FULLSCREEN"
	games_make_wrapper CounterStrike2D ./CounterStrike2D \
		"${GAMES_PREFIX_OPT}"/${PN} "${GAMES_PREFIX_OPT}"/${PN}

	prepgamesdirs

	# OpenAL is default sound driver
	sed -i 's:^sounddriver.*$:sounddriver OpenAL Default:' "${D}/${GAMES_PREFIX_OPT}/${PN}/sys/config.cfg"

	# fixing permissions
	chmod -R g+w "${D}/${GAMES_PREFIX_OPT}/${PN}/maps"
	chmod -R g+w "${D}/${GAMES_PREFIX_OPT}/${PN}/screens"
	chmod -R g+w "${D}/${GAMES_PREFIX_OPT}/${PN}/sys"
	fperms ug+x "${GAMES_PREFIX_OPT}/${PN}/CounterStrike2D"
}
